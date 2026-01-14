import 'package:flutter/material.dart';
import 'package:jolly_podcast/dashboard/home_screen/model/episode_model.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';

class EpisodeCard extends StatelessWidget {
  final EpisodeModel episode;
  final VoidCallback onTap;
  final bool large;

  // Optional action callbacks
  final VoidCallback? onLike;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;
  final VoidCallback? onMore;
  final VoidCallback? onPlay;

  const EpisodeCard({
    super.key,
    required this.episode,
    required this.onTap,
    this.large = false,
    this.onLike,
    this.onDownload,
    this.onShare,
    this.onMore,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = large ? 200 : 140;
    final double cardWidth = large ? double.infinity : 200;

    // downscale decode for performance
    final int cacheW = large ? 900 : 500;
    final int cacheH = (imageHeight * 2).round();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade900,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail + Play overlay
            SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    episode.thumbnail,
                    fit: BoxFit.cover,
                    cacheWidth: cacheW,
                    cacheHeight: cacheH,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Play button (center)
                  Center(
                    child: InkWell(
                      onTap: onPlay ?? onTap,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.45),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
              child: Text(
                episode.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),

            // Action icons row (like in your screenshot)
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 8),
              child: Row(
                children: [
                  _ActionIcon(
                    icon: Icons.favorite_border,
                    onTap: onLike,
                  ),
                  _ActionIcon(
                    icon: Icons.file_download_outlined,
                    onTap: onDownload,
                  ),
                  _ActionIcon(
                    icon: Icons.share_outlined,
                    onTap: onShare,
                  ),
                  const Spacer(),
                  _ActionIcon(
                    icon: Icons.more_horiz,
                    onTap: onMore,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _ActionIcon({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Icon(
          icon,
          color: AppColors.color2.withOpacity(0.9),
          size: 20,
        ),
      ),
    );
  }
}
