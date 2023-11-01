import 'package:core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = RemoveWatchlist(mockWatchlistRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockWatchlistRepository.removeWatchlistMovie(testMovieDetail))
        .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
    // act
    final result = await usecase.executeMovie(testMovieDetail);
    // assert
    verify(mockWatchlistRepository.removeWatchlistMovie(testMovieDetail));
    expect(result, const Right(watchlistRemoveSuccessMessage));
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockWatchlistRepository.removeWatchlistTvShow(testTvDetail))
        .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
    // act
    final result = await usecase.executeTv(testTvDetail);
    // assert
    verify(mockWatchlistRepository.removeWatchlistTvShow(testTvDetail));
    expect(result, const Right(watchlistRemoveSuccessMessage));
  });
}
