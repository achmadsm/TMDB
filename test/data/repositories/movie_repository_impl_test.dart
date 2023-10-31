import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/common/exception.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/data/models/movie_model.dart';
import 'package:tmdb/data/repositories/movie_repository_impl.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenAnswer((_) async => testMovieModelList);
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenAnswer((_) async => testMovieModelList);
      // act
      final result = await repository.getPopularMovies();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenAnswer((_) async => testMovieModelList);
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Movie Detail', () {
    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(testId))
          .thenAnswer((_) async => testMovieDetailModel);
      // act
      final result = await repository.getMovieDetail(testId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(testId));
      expect(result, equals(const Right(testMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(testId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieDetail(testId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(testId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(testId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieDetail(testId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(testId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(testId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getMovieRecommendations(testId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(testId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(testId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieRecommendations(testId);
      // assertbuild runner
      verify(mockRemoteDataSource.getMovieRecommendations(testId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(testId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieRecommendations(testId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(testId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(testQueryMovie))
          .thenAnswer((_) async => testMovieModelList);
      // act
      final result = await repository.searchMovies(testQueryMovie);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(testQueryMovie))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchMovies(testQueryMovie);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(testQueryMovie))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchMovies(testQueryMovie);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Save Watchlist', () {
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

  group('Remove Watchlist', () {
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

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      when(mockLocalDataSource.getMovieById(testId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(testId);
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
}
