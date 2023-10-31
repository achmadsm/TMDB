import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/common/exception.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/data/models/tv_model.dart';
import 'package:tmdb/data/repositories/tv_repository_impl.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('On The Air Tv Shows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvShows())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getOnTheAirTvShows();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvShows());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTvShows();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvShows());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTvShows();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvShows());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Shows', () {
    test('should return tv show list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getPopularTvShows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvShows();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvShows();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Shows', () {
    test('should return tv show list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Show Detail', () {
    test(
        'should return Tv Show data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(testId))
          .thenAnswer((_) async => testTvDetailModel);
      // act
      final result = await repository.getTvShowDetail(testId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(testId));
      expect(result, equals(const Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(testId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowDetail(testId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(testId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(testId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowDetail(testId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(testId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Show Recommendations', () {
    final tTvList = <TvModel>[];

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(testId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvShowRecommendations(testId);
      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(testId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(testId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowRecommendations(testId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvShowRecommendations(testId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(testId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowRecommendations(testId);
      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(testId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv Shows', () {
    test('should return tv show list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(testQueryTvShow))
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.searchTvShows(testQueryTvShow);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(testQueryTvShow))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvShows(testQueryTvShow);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(testQueryTvShow))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvShows(testQueryTvShow);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Save Watchlist', () {
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

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      when(mockLocalDataSource.getTvById(testId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(testId);
      // assert
      expect(result, false);
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
