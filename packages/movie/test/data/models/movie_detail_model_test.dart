import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_model.dart';

import '../../../../core/test/json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieDetailModel', () {
    test('should be a subclass of MovieDetail entity', () async {
      final result = testMovieDetailModel.toEntity();
      expect(result, testMovieDetail);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('movie', 'dummy_data/movie.json'));
      // act
      final result = MovieDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, testMovieDetailModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testMovieDetailModel.toJson();
      // assert
      final expectedJsonMap = {
        "genres": [
          {"id": 1, "name": "name"}
        ],
        "id": 1,
        "overview": "overview",
        "poster_path": "posterPath",
        "runtime": 1,
        "title": "title",
        "vote_average": 1.0
      };
      expect(result, expectedJsonMap);
    });
  });
}
