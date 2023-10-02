import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/domain/usecases/get_tv_show_recommendations.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvShowRecommendations(mockTvRepository);
  });

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(mockTvRepository.getTvShowRecommendations(testId))
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute(testId);
    // assert
    expect(result, Right(testTvList));
  });
}
