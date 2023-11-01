import 'package:core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchList usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = SaveWatchList(mockWatchlistRepository);
  });

  test('should save watchlist movie from repository', () async {
    // arrange
    when(mockWatchlistRepository.saveWatchlistMovie(testMovieDetail))
        .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
    // act
    final result = await usecase.executeMovie(testMovieDetail);
    // assert
    verify(mockWatchlistRepository.saveWatchlistMovie(testMovieDetail));
    expect(result, const Right(watchlistAddSuccessMessage));
  });

  test('should save watchlist tv from repository', () async {
    // arrange
    when(mockWatchlistRepository.saveWatchlistTvShow(testTvDetail))
        .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
    // act
    final result = await usecase.executeTv(testTvDetail);
    // assert
    verify(mockWatchlistRepository.saveWatchlistTvShow(testTvDetail));
    expect(result, const Right(watchlistAddSuccessMessage));
  });
}
