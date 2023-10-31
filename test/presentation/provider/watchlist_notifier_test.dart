import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/common/state_enum.dart';
import 'package:tmdb/domain/usecases/get_watchlist_movies.dart';
import 'package:tmdb/domain/usecases/get_watchlist_status.dart';
import 'package:tmdb/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:tmdb/domain/usecases/remove_watchlist.dart';
import 'package:tmdb/domain/usecases/save_watchlist.dart';
import 'package:tmdb/presentation/provider/watchlist_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_notifier_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchlistTvShows,
  GetWatchlistStatus,
  SaveWatchList,
  RemoveWatchlist,
])
void main() {
  late WatchlistNotifier provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockSaveWatchList mockSaveWatchList;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listerCallCount;

  setUp(() {
    listerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    mockGetWatchlistStatus = MockGetWatchlistStatus();
    mockSaveWatchList = MockSaveWatchList();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = WatchlistNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchlistTvShows: mockGetWatchlistTvShows,
      getWatchlistStatus: mockGetWatchlistStatus,
      saveWatchList: mockSaveWatchList,
      removeWatchList: mockRemoveWatchlist,
    )..addListener(() {
        listerCallCount += 1;
      });
  });

  group('Movie', () {
    test('should change movies data when data is empty', () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right([]));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistMovieState, RequestState.empty);
      expect(provider.watchlistMovies, []);
      expect(listerCallCount, 2);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right(testWatchlistMovieList));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistMovieState, RequestState.loaded);
      expect(provider.watchlistMovies, testWatchlistMovieList);
      expect(listerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Can\'t get data')));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistMovieState, RequestState.error);
      expect(provider.message, 'Can\'t get data');
      expect(listerCallCount, 2);
    });

    test('should get watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.executeMovie(testId))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatusMovie(testId);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchList.executeMovie(testMovieDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistMovie(testMovieDetail);
      // assert
      verify(mockSaveWatchList.executeMovie(testMovieDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.executeMovie(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.removeFromWatchlistMovie(testMovieDetail);
      // assert
      verify(mockRemoveWatchlist.executeMovie(testMovieDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchList.executeMovie(testMovieDetail))
          .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
      when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistMovie(testMovieDetail);
      // assert
      verify(mockGetWatchlistStatus.executeMovie(testMovieDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, watchlistAddSuccessMessage);
      expect(listerCallCount, 1);
    });

    test('should update watchlist status when remove watchlist success',
        () async {
      // arrange
      when(mockRemoveWatchlist.executeMovie(testMovieDetail))
          .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
      when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.removeFromWatchlistMovie(testMovieDetail);
      // assert
      verify(mockGetWatchlistStatus.executeMovie(testMovieDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, watchlistRemoveSuccessMessage);
      expect(listerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchList.executeMovie(testMovieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistMovie(testMovieDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listerCallCount, 1);
    });

    test('should update watchlist message when remove watchlist failed',
        () async {
      // arrange
      when(mockRemoveWatchlist.executeMovie(testMovieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistMovie(testMovieDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listerCallCount, 1);
    });
  });

  group('Tv', () {
    test('should change tv shows data when data is empty', () async {
      // arrange
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => const Right([]));
      // act
      await provider.fetchWatchlistTvShows();
      // assert
      expect(provider.watchlistTvState, RequestState.empty);
      expect(provider.watchlistTvShows, []);
      expect(listerCallCount, 2);
    });

    test('should change tv shows data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => const Right(testWatchlistTvList));
      // act
      await provider.fetchWatchlistTvShows();
      // assert
      expect(provider.watchlistTvState, RequestState.loaded);
      expect(provider.watchlistTvShows, testWatchlistTvList);
      expect(listerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistTvShows.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Can\'t get data')));
      // act
      await provider.fetchWatchlistTvShows();
      // assert
      expect(provider.watchlistTvState, RequestState.error);
      expect(provider.message, 'Can\'t get data');
      expect(listerCallCount, 2);
    });

    test('should get watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.executeTv(testId))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatusTv(testId);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchList.executeTv(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      verify(mockSaveWatchList.executeTv(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.executeTv(testTvDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.removeFromWatchlistTv(testTvDetail);
      // assert
      verify(mockRemoveWatchlist.executeTv(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchList.executeTv(testTvDetail))
          .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
      when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      verify(mockGetWatchlistStatus.executeTv(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, watchlistAddSuccessMessage);
      expect(listerCallCount, 1);
    });

    test('should update watchlist status when remove watchlist success',
        () async {
      // arrange
      when(mockRemoveWatchlist.executeTv(testTvDetail))
          .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
      when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.removeFromWatchlistTv(testTvDetail);
      // assert
      verify(mockGetWatchlistStatus.executeTv(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, watchlistRemoveSuccessMessage);
      expect(listerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchList.executeTv(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listerCallCount, 1);
    });

    test('should update watchlist message when remove watchlist failed',
        () async {
      // arrange
      when(mockRemoveWatchlist.executeTv(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistTv(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listerCallCount, 1);
    });
  });
}
