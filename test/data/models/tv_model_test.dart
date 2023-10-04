import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb/data/models/tv_model.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('TvModel', () {
    test('should be a subclass of Tv entity', () async {
      final result = testTvModel.toEntity();
      expect(result, testTv);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_show.json'));
      // act
      final result = TvModel.fromJson(jsonMap);
      // assert
      expect(result, testTvModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
      };
      expect(result, expectedJsonMap);
    });
  });
}
