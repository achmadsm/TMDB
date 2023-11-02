import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_detail_model.dart';

import '../../../../core/test/json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  group('TvDetailModel', () {
    test('should be a subclass of TvDetail entity', () async {
      final result = testTvDetailModel.toEntity();
      expect(result, testTvDetail);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('tv', 'dummy_data/tv_show.json'));
      // act
      final result = TvDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, testTvDetailModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvDetailModel.toJson();
      // assert
      final expectedJsonMap = {
        "episode_run_time": [1],
        "genres": [
          {"id": 1, "name": "name"}
        ],
        "id": 1,
        "name": "title",
        "overview": "overview",
        "poster_path": "posterPath",
        "vote_average": 1.0
      };
      expect(result, expectedJsonMap);
    });
  });
}
