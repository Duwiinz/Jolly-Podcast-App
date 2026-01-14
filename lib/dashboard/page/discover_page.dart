import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/dashboard/home_screen/cubit/episode_cubit.dart';
import 'package:jolly_podcast/dashboard/home_screen/cubit/episode_state.dart';
import 'package:jolly_podcast/utils_folder/episode_card.dart';
import 'episode_details_page.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeCubit, EpisodeState>(
      builder: (context, state) {
        if (state is EpisodeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is EpisodeLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Hot & trending header with image icon
                Row(
                  children: [
                    Image.asset(
                      'assets/images/trendingIcon.png', // your fire icon
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Hot & trending episodes',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                SizedBox(
                  height: 260,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.trending.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, index) {
                      final episode = state.trending[index];
                      return EpisodeCard(
                        episode: episode,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EpisodeDetailsPage(episode: episode),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // ✅ Editor’s Pick header with image icon
                Row(
                  children: [
                    Image.asset(
                      'assets/images/editorsPickIcon.png', // your star icon
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Editor’s Pick",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                EpisodeCard(
                  episode: state.editorsPick.first,
                  large: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EpisodeDetailsPage(
                          episode: state.editorsPick.first,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }

        if (state is EpisodeError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
