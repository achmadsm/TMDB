import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/common/state_enum.dart';
import 'package:tmdb/domain/entities/detail_args.dart';
import 'package:tmdb/presentation/pages/detail_page.dart';
import 'package:tmdb/presentation/provider/movie_detail_notifier.dart';
import 'package:tmdb/presentation/provider/tv_detail_notifier.dart';
import 'package:tmdb/presentation/provider/watchlist_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier, TvDetailNotifier, WatchlistNotifier])
void main() {
  late MockMovieDetailNotifier mockMovieDetailNotifier;
  late MockTvDetailNotifier mockTvDetailNotifier;
  late MockWatchlistNotifier mockWatchlistNotifier;

  setUp(() {
    mockMovieDetailNotifier = MockMovieDetailNotifier();
    mockTvDetailNotifier = MockTvDetailNotifier();
    mockWatchlistNotifier = MockWatchlistNotifier();
  });

  Widget makeTestableWidgetMovie(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieDetailNotifier>.value(
          value: mockMovieDetailNotifier,
        ),
        ChangeNotifierProvider<WatchlistNotifier>.value(
          value: mockWatchlistNotifier,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget makeTestableWidgetTv(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TvDetailNotifier>.value(
          value: mockTvDetailNotifier,
        ),
        ChangeNotifierProvider<WatchlistNotifier>.value(
          value: mockWatchlistNotifier,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Detail Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidgetMovie(
          DetailPage(args: DetailArgs(id: testId, isMovie: true))));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
      when(mockMovieDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movieRecommendations)
          .thenReturn([testMovie]);
      when(mockWatchlistNotifier.isAddedToWatchlist).thenReturn(false);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(makeTestableWidgetMovie(
          DetailPage(args: DetailArgs(id: testId, isMovie: true))));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display check icon when movie is added to watchlist',
        (WidgetTester tester) async {
      when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
      when(mockMovieDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movieRecommendations)
          .thenReturn([testMovie]);
      when(mockWatchlistNotifier.isAddedToWatchlist).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(makeTestableWidgetMovie(
          DetailPage(args: DetailArgs(id: testId, isMovie: true))));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when movie is added to watchlist',
        (WidgetTester tester) async {
      when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
      when(mockMovieDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movieRecommendations)
          .thenReturn([testMovie]);
      when(mockWatchlistNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockWatchlistNotifier.watchlistMessage)
          .thenReturn(watchlistAddSuccessMessage);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidgetMovie(
          DetailPage(args: DetailArgs(id: testId, isMovie: true))));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(watchlistAddSuccessMessage), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist is failed',
        (WidgetTester tester) async {
      when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
      when(mockMovieDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movieRecommendations)
          .thenReturn([testMovie]);
      when(mockWatchlistNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockWatchlistNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidgetMovie(
          DetailPage(args: DetailArgs(id: testId, isMovie: true))));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.error);
      when(mockMovieDetailNotifier.message).thenReturn('Error');

      final textFinder = find.text('Error');

      await tester.pumpWidget(makeTestableWidgetMovie(
          DetailPage(args: DetailArgs(id: testId, isMovie: true))));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Tv Detail Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidgetTv(
          DetailPage(args: DetailArgs(id: testId, isMovie: false))));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tv).thenReturn(testTvDetail);
      when(mockTvDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTv]);
      when(mockWatchlistNotifier.isAddedToWatchlist).thenReturn(false);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(makeTestableWidgetTv(
          DetailPage(args: DetailArgs(id: testId, isMovie: false))));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display check icon when movie is added to watchlist',
        (WidgetTester tester) async {
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tv).thenReturn(testTvDetail);
      when(mockTvDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTv]);
      when(mockWatchlistNotifier.isAddedToWatchlist).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(makeTestableWidgetTv(
          DetailPage(args: DetailArgs(id: testId, isMovie: false))));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when movie is added to watchlist',
        (WidgetTester tester) async {
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tv).thenReturn(testTvDetail);
      when(mockTvDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTv]);
      when(mockWatchlistNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockWatchlistNotifier.watchlistMessage)
          .thenReturn(watchlistAddSuccessMessage);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidgetTv(
          DetailPage(args: DetailArgs(id: testId, isMovie: false))));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(watchlistAddSuccessMessage), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist is failed',
        (WidgetTester tester) async {
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tv).thenReturn(testTvDetail);
      when(mockTvDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTv]);
      when(mockWatchlistNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockWatchlistNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidgetTv(
          DetailPage(args: DetailArgs(id: testId, isMovie: false))));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.error);
      when(mockTvDetailNotifier.message).thenReturn('Error');

      final textFinder = find.text('Error');

      await tester.pumpWidget(makeTestableWidgetTv(
          DetailPage(args: DetailArgs(id: testId, isMovie: false))));

      expect(textFinder, findsOneWidget);
    });
  });
}
