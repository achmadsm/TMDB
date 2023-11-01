import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/data/repositories/watchlist_repository_impl.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistRepositoryImpl repository;
  late MockWatchlistLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockWatchlistLocalDataSource();
    repository = WatchlistRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('Save Watchlist Movie', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => watchlistAddSuccessMessage);
      // act
      final result = await repository.saveWatchlistMovie(testMovieDetail);
      // assert
      expect(result, const Right(watchlistAddSuccessMessage));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistMovie(testMovieDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Save Watchlist Tv', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable))
          .thenAnswer((_) async => watchlistAddSuccessMessage);
      // act
      final result = await repository.saveWatchlistTvShow(testTvDetail);
      // assert
      expect(result, const Right(watchlistAddSuccessMessage));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTvShow(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist Movie', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => watchlistRemoveSuccessMessage);
      // act
      final result = await repository.removeWatchlistMovie(testMovieDetail);
      // assert
      expect(result, const Right(watchlistRemoveSuccessMessage));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistMovie(testMovieDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable))
          .thenAnswer((_) async => watchlistRemoveSuccessMessage);
      // act
      final result = await repository.removeWatchlistTvShow(testTvDetail);
      // assert
      expect(result, const Right(watchlistRemoveSuccessMessage));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTvShow(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Watchlist Movie Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      when(mockLocalDataSource.getMovieById(1)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistMovie(1);
      // assert
      expect(result, false);
    });
  });

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      when(mockLocalDataSource.getTvById(1)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTv(1);
      // assert
      expect(result, false);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });

  group('Get Watchlist Tv Shows', () {
    test('should return list of tv shows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTvShows();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
