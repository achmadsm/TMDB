import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/common/state_enum.dart';
import 'package:tmdb/domain/entities/detail_args.dart';
import 'package:tmdb/domain/entities/movie.dart';
import 'package:tmdb/domain/entities/tv.dart';
import 'package:tmdb/presentation/pages/detail_page.dart';
import 'package:tmdb/presentation/provider/movie_detail_notifier.dart';
import 'package:tmdb/presentation/provider/tv_detail_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier, TvDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockMovieDetailNotifier;
  late MockTvDetailNotifier mockTvDetailNotifier;

  setUp(() {
    mockMovieDetailNotifier = MockMovieDetailNotifier();
    mockTvDetailNotifier = MockTvDetailNotifier();
  });

  Widget makeTestableWidgetMovie(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockMovieDetailNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget makeTestableWidgetTv(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockTvDetailNotifier,
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
          DetailPage(args: DetailArgs(id: 1, isMovie: true))));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
      when(mockMovieDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockMovieDetailNotifier.movieRecommendations).thenReturn(<Movie>[]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidgetMovie(
          DetailPage(args: DetailArgs(id: 1, isMovie: true))));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.error);
      when(mockMovieDetailNotifier.message).thenReturn('Error');

      final textFinder = find.text('Error');

      await tester.pumpWidget(makeTestableWidgetMovie(
          DetailPage(args: DetailArgs(id: 1, isMovie: true))));

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
          DetailPage(args: DetailArgs(id: 1, isMovie: false))));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tv).thenReturn(testTvDetail);
      when(mockTvDetailNotifier.recommendationState)
          .thenReturn(RequestState.loaded);
      when(mockTvDetailNotifier.tvRecommendations).thenReturn(<Tv>[testTv]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidgetTv(
          DetailPage(args: DetailArgs(id: 1, isMovie: false))));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.error);
      when(mockTvDetailNotifier.message).thenReturn('Error');

      final textFinder = find.text('Error');

      await tester.pumpWidget(makeTestableWidgetTv(
          DetailPage(args: DetailArgs(id: 1, isMovie: false))));

      expect(textFinder, findsOneWidget);
    });
  });
}
