import 'package:core/presentation/pages/popular_page.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/provider/tv_list_notifier.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieListNotifier mockMovieListNotifier;
  late MockTvListNotifier mockTvListNotifier;

  setUp(() {
    mockMovieListNotifier = MockMovieListNotifier();
    mockTvListNotifier = MockTvListNotifier();
  });

  Widget makeTestableWidgetMovie(Widget body) {
    return ChangeNotifierProvider<MovieListNotifier>.value(
      value: mockMovieListNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget makeTestableWidgetTvShow(Widget body) {
    return ChangeNotifierProvider<TvListNotifier>.value(
      value: mockTvListNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Popular Movies Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockMovieListNotifier.popularMoviesState)
          .thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(
          makeTestableWidgetMovie(const PopularPage(isMovie: true)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(mockMovieListNotifier.popularMoviesState)
          .thenReturn(RequestState.loaded);
      when(mockMovieListNotifier.popularMovies).thenReturn(testMovieList);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(
          makeTestableWidgetMovie(const PopularPage(isMovie: true)));
      await tester.drag(listViewFinder, const Offset(0, -300));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockMovieListNotifier.popularMoviesState)
          .thenReturn(RequestState.error);
      when(mockMovieListNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(
          makeTestableWidgetMovie(const PopularPage(isMovie: true)));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Popular Tv Shows Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockTvListNotifier.popularTvShowsState)
          .thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(
          makeTestableWidgetTvShow(const PopularPage(isMovie: false)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(mockTvListNotifier.popularTvShowsState)
          .thenReturn(RequestState.loaded);
      when(mockTvListNotifier.popularTvShows).thenReturn(testTvList);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(
          makeTestableWidgetTvShow(const PopularPage(isMovie: false)));
      await tester.drag(listViewFinder, const Offset(0, -300));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockTvListNotifier.popularTvShowsState)
          .thenReturn(RequestState.error);
      when(mockTvListNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(
          makeTestableWidgetTvShow(const PopularPage(isMovie: false)));

      expect(textFinder, findsOneWidget);
    });
  });
}
