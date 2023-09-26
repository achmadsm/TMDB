import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/common/exception.dart';
import 'package:tmdb/data/models/tv_detail_model.dart';
import 'package:tmdb/data/models/tv_model.dart';
import 'package:tmdb/data/models/tv_response.dart';

abstract class TvShowRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTvShows();

  Future<List<TvModel>> getPopularTvShows();

  Future<List<TvModel>> getTopRatedTvShows();

  Future<TvDetailResponse> getTvShowDetail(int id);

  Future<List<TvModel>> getTvShowRecommendations(int id);

  Future<List<TvModel>> searchTvShows(String query);
}

class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {
  final http.Client client;

  TvShowRemoteDataSourceImpl({required this.client});

  static const tv = 'tv';

  @override
  Future<List<TvModel>> getOnTheAirTvShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/$tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/$tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/$tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvShowDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/$tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvShowRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/$tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvShows(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/$tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
