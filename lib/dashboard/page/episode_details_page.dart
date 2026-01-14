import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jolly_podcast/dashboard/home_screen/model/episode_model.dart';
import 'package:just_audio/just_audio.dart';

class EpisodeDetailsPage extends StatefulWidget {
  final EpisodeModel episode;

  const EpisodeDetailsPage({super.key, required this.episode});

  @override
  State<EpisodeDetailsPage> createState() => _EpisodeDetailsPageState();
}

class _EpisodeDetailsPageState extends State<EpisodeDetailsPage> {
  late final AudioPlayer _player;

  // optional: show loading state while preparing audio
  bool _preparing = true;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    // Don't block first frame
    Future.microtask(() async {
      try {
        await _player.setUrl(widget.episode.audioUrl);
      } catch (_) {
        // you can show snackbar if you want
      } finally {
        if (mounted) setState(() => _preparing = false);
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _fmt(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$mm:$ss";
  }

  Future<void> _seekRelative(Duration offset) async {
    final pos = _player.position;
    final dur = _player.duration ?? Duration.zero;
    var target = pos + offset;
    if (target < Duration.zero) target = Duration.zero;
    if (dur != Duration.zero && target > dur) target = dur;
    await _player.seek(target);
  }

  @override
  Widget build(BuildContext context) {
    final episode = widget.episode;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF17B857), Color(0xFF0D6B3A), Color(0xFF0A0F0C)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar (down arrow like screenshot)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      // Cover art card
                      Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          episode.thumbnail,
                          fit: BoxFit.cover,
                          cacheWidth: 900,
                          loadingBuilder: (c, child, p) => p == null
                              ? child
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                          errorBuilder: (_, __, ___) => Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Title
                      Text(
                        episode.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Description
                      Text(
                        episode.description,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Seek bar + times (uses streams)
                      StreamBuilder<Duration>(
                        stream: _player.positionStream,
                        builder: (context, posSnap) {
                          final position = posSnap.data ?? Duration.zero;
                          final duration = _player.duration ?? Duration.zero;

                          final double max =
                              (duration.inMilliseconds > 0
                                      ? duration.inMilliseconds
                                      : 1)
                                  .toDouble();

                          final double value = position.inMilliseconds
                              .toDouble()
                              .clamp(0.0, max);

                          return Column(
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 3,
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 6,
                                  ),
                                ),
                                child: Slider(
                                  value: value,
                                  max: max,
                                  onChanged: (v) {
                                    _player.seek(
                                      Duration(milliseconds: v.toInt()),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _fmt(position),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      _fmt(duration),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 8),

                      // Playback controls row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  _seekRelative(const Duration(seconds: -10)),
                              icon: const Icon(
                                Icons.replay_10,
                                color: Colors.white,
                              ),
                              iconSize: 30,
                            ),

                            // Play/Pause button (center)
                            StreamBuilder<PlayerState>(
                              stream: _player.playerStateStream,
                              builder: (context, snap) {
                                final state = snap.data;
                                final playing = state?.playing ?? false;
                                final processing = state?.processingState;

                                final isLoading =
                                    _preparing ||
                                    processing == ProcessingState.loading ||
                                    processing == ProcessingState.buffering;

                                return GestureDetector(
                                  onTap: isLoading
                                      ? null
                                      : () async {
                                          if (playing) {
                                            await _player.pause();
                                          } else {
                                            await _player.play();
                                          }
                                        },
                                  child: Container(
                                    width: 64,
                                    height: 64,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Icon(
                                              playing
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              size: 36,
                                              color: Colors.black,
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            IconButton(
                              onPressed: () =>
                                  _seekRelative(const Duration(seconds: 10)),
                              icon: const Icon(
                                Icons.forward_10,
                                color: Colors.white,
                              ),
                              iconSize: 30,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Action pills row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _PillButton(
                            icon: Icons.queue_music,
                            text: "Add to queue",
                            onTap: () {
                              // TODO
                            },
                          ),
                          const SizedBox(width: 10),
                          _PillButton(
                            icon: Icons.favorite_border,
                            text: "Save",
                            onTap: () {
                              // TODO
                            },
                          ),
                          const SizedBox(width: 10),
                          _PillButton(
                            icon: Icons.share_outlined,
                            text: "Share episode",
                            onTap: () {
                              // TODO: use share_plus if you want
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Bottom buttons
                      Row(
                        children: [
                          Expanded(
                            child: _BigButton(
                              text: "Add to playlist",
                              onTap: () {
                                // TODO
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _BigButton(
                              text: "Go to episode page",
                              onTap: () {
                                // TODO
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _PillButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _BigButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
