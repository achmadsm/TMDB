import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/domain/usecases/search_tv_shows.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvShows(mockTvRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvRepository.searchTvShows(testQueryTvShow))
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute(testQueryTvShow);
    // assert
    expect(result, Right(testTvList));
  });
}
