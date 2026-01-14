import '../model/episode_model.dart';

abstract class EpisodeState {}

class EpisodeInitial extends EpisodeState {}

class EpisodeLoading extends EpisodeState {}

class EpisodeLoaded extends EpisodeState {
  final List<EpisodeModel> trending;
  final List<EpisodeModel> editorsPick;

   EpisodeLoaded({
    required this.trending,
    required this.editorsPick,
  });
}


class EpisodeError extends EpisodeState {
  final String message;
  EpisodeError(this.message);
}
