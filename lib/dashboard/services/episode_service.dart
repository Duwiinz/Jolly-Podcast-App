import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:jolly_podcast/dashboard/home_screen/model/episode_model.dart';
import 'package:jolly_podcast/http/http_service.dart';
import 'package:jolly_podcast/network/api_routes.dart';

class EpisodeService {
  final HttpClientService client;

  EpisodeService(this.client);

  /// Trending Episodes (LIST)
  Future<List<EpisodeModel>> getTrendingEpisodes() async {
    final response = await client.get(ApiRoutes.trendingEpisodes);

    final decoded = await compute(jsonDecode, response.body);

    // Correct path based on your API
    final List list =
        decoded['data']['data']['data'] as List;

    return list.map((e) => EpisodeModel.fromJson(e)).toList();
  }

  /// Editor’s Pick (SINGLE OBJECT)
  Future<List<EpisodeModel>> getEditorsPick() async {
    final response = await client.get(ApiRoutes.editorsPickEpisodes);

    final decoded = await compute(jsonDecode, response.body);

    final Map<String, dynamic> episode =
        decoded['data']['data'];

    // wrap single object as list for UI consistency
    return [EpisodeModel.fromJson(episode)];
  }
}
