import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/domain/usecases/get_watchlist_tv_shows.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvShows(mockTvRepository);
  });

  test('should get list of tv shows from repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTvShows())
        .thenAnswer((_) async => const Right(testWatchlistTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, const Right(testWatchlistTvList));
  });
}
