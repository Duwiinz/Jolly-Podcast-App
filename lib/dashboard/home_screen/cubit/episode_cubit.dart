import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'episode_state.dart';
import '../../services/episode_service.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  final EpisodeService service;

  EpisodeCubit(this.service) : super(EpisodeInitial());

  Future<void> fetchEpisodes() async {
    emit(EpisodeLoading());

    try {
      final trending = await service.getTrendingEpisodes();
      final editorsPick = await service.getEditorsPick();

      // Debug logs
      log('Trending count: ${trending.length}');
      log('Editors pick count: ${editorsPick.length}');

      emit(
  EpisodeLoaded(
    trending: trending,
    editorsPick: editorsPick,
  ),
);
    } catch (e, stack) {
      log('[EpisodeCubit] error: $e');
      log('[EpisodeCubit] stack: $stack');
      emit(EpisodeError('Failed to load episodes'));
    }
  }
}

