import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/domain/usecases/save_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchList usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchList(
      mockMovieRepository,
      mockTvRepository,
    );
  });

  test('should save watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlistMovie(testMovieDetail))
        .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
    // act
    final result = await usecase.executeMovie(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlistMovie(testMovieDetail));
    expect(result, const Right(watchlistAddSuccessMessage));
  });

  test('should save watchlist tv from repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlistTvShow(testTvDetail))
        .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
    // act
    final result = await usecase.executeTv(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchlistTvShow(testTvDetail));
    expect(result, const Right(watchlistAddSuccessMessage));
  });
}
