import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/dashboard/home_screen/cubit/episode_cubit.dart';
import 'package:jolly_podcast/dashboard/home_screen/cubit/episode_state.dart';
// import 'package:jolly_podcast/dashboard/page/episode_details_page.dart';
// import 'package:jolly_podcast/utils_folder/episode_card.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeCubit, EpisodeState>(
      builder: (context, state) {
        // if (state is EpisodeLoading) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        // if (state is EpisodeLoaded) {
        //   return SingleChildScrollView(
        //     padding: const EdgeInsets.all(16),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const Text('🔥 Hot & Trending', style: TextStyle(fontSize: 18)),
        //         const SizedBox(height: 12),
        //         SizedBox(
        //           height: 260,
        //           child: ListView.separated(
        //             scrollDirection: Axis.horizontal,
        //             itemCount: state.trending.length,
        //             separatorBuilder: (_, __) => const SizedBox(width: 12),
        //             itemBuilder: (_, index) {
        //               final episode = state.trending[index];
        //               return EpisodeCard(
        //                 episode: episode,
        //                 onTap: () {
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (_) => EpisodeDetailsPage(episode: episode),
        //                     ),
        //                   );
        //                 },
        //               );
        //             },
        //           ),
        //         ),
        //         const SizedBox(height: 24),
        //         const Text('⭐ Editor’s Pick', style: TextStyle(fontSize: 18)),
        //         const SizedBox(height: 12),
        //         EpisodeCard(
        //           episode: state.editorsPick.first,
        //           large: true,
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (_) => EpisodeDetailsPage(episode: state.editorsPick.first),
        //               ),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //   );
        // }

        if (state is EpisodeError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
