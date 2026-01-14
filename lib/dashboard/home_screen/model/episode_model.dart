class EpisodeModel {
  final int id;
  final String title;
  final String thumbnail;
  final String description;
  final String audioUrl;
  final int duration;
  final String podcastTitle;
  final String podcastAuthor;

  EpisodeModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.audioUrl,
    required this.duration,
    required this.podcastTitle,
    required this.podcastAuthor,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      title: json['title'] ?? '',
      thumbnail: json['picture_url'] ?? '',
      description: json['description'] ?? '',
      audioUrl: json['content_url'] ?? '',
      duration: json['duration'] ?? 0,
      podcastTitle: json['podcast']?['title'] ?? '',
      podcastAuthor: json['podcast']?['author'] ?? '',
    );
  }
}
