import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/domain/usecases/remove_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlist(
      mockMovieRepository,
      mockTvRepository,
    );
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlistMovie(testMovieDetail))
        .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
    // act
    final result = await usecase.executeMovie(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlistMovie(testMovieDetail));
    expect(result, const Right(watchlistRemoveSuccessMessage));
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlistTvShow(testTvDetail))
        .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
    // act
    final result = await usecase.executeTv(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchlistTvShow(testTvDetail));
    expect(result, const Right(watchlistRemoveSuccessMessage));
  });
}
