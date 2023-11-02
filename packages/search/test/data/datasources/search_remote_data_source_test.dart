import 'dart:convert';

import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:search/data/datasources/search_remote_data_source.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../../../core/test/json_reader.dart';
import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  const movie = 'movie';
  const tv = 'tv';

  final tMovieList = MovieResponse.fromJson(
          json.decode(readJson('movie', 'dummy_data/movies.json')))
      .movieList;
  final tTvList = TvResponse.fromJson(
          json.decode(readJson('tv', 'dummy_data/tv_shows.json')))
      .tvList;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SearchRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('search movies', () {
    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl/search/$movie?$apiKey&query=$testQueryMovie')))
          .thenAnswer((_) async =>
              http.Response(readJson('movie', 'dummy_data/movies.json'), 200));
      // act
      final result = await dataSource.searchMovies(testQueryMovie);
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl/search/$movie?$apiKey&query=$testQueryMovie')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(testQueryMovie);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv shows', () {
    test('should return list of tv shows when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(
              Uri.parse('$baseUrl/search/$tv?$apiKey&query=$testQueryTvShow')))
          .thenAnswer((_) async =>
              http.Response(readJson('tv', 'dummy_data/tv_shows.json'), 200));
      // act
      final result = await dataSource.searchTvShows(testQueryTvShow);
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(
              Uri.parse('$baseUrl/search/$tv?$apiKey&query=$testQueryTvShow')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvShows(testQueryTvShow);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
