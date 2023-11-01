import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_response.dart';

import '../../../../core/test/json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  const tMovieResponseModel = MovieResponse(movieList: [testMovieModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/movies.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "id": 1,
            "overview": "overview",
            "poster_path": "posterPath",
            "title": "title"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
