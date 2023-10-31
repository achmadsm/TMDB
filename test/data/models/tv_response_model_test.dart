import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb/data/models/tv_model.dart';
import 'package:tmdb/data/models/tv_response.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  const tTvResponseModel = TvResponse(tvList: <TvModel>[testTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_shows.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "id": 1,
            "name": "title",
            "overview": "overview",
            "poster_path": "posterPath"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
