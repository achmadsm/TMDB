import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_model.dart';

import '../../../../core/test/json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieModel', () {
    test('should be a subclass of Movie entity', () async {
      final result = testMovieModel.toEntity();
      expect(result, testMovie);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/movie.json'));
      // act
      final result = MovieModel.fromJson(jsonMap);
      // assert
      expect(result, testMovieModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testMovieModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "overview": "overview",
        "poster_path": "posterPath",
        "title": "title"
      };
      expect(result, expectedJsonMap);
    });
  });
}
