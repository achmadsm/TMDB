import 'dart:convert';

import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:http/http.dart' as http;
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTvShows();

  Future<List<TvModel>> getPopularTvShows();

  Future<List<TvModel>> getTopRatedTvShows();

  Future<TvDetailResponse> getTvShowDetail(int id);

  Future<List<TvModel>> getTvShowRecommendations(int id);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

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
}
