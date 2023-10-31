import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/common/state_enum.dart';
import 'package:tmdb/presentation/pages/search_page.dart';
import 'package:tmdb/presentation/provider/movie_search_notifier.dart';
import 'package:tmdb/presentation/provider/tv_search_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieSearchNotifier mockMovieSearchNotifier;
  late MockTvSearchNotifier mockTvSearchNotifier;

  setUp(() {
    mockMovieSearchNotifier = MockMovieSearchNotifier();
    mockTvSearchNotifier = MockTvSearchNotifier();
  });

  Widget makeTestableWidgetMovie(Widget body) {
    return ChangeNotifierProvider<MovieSearchNotifier>.value(
      value: mockMovieSearchNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget makeTestableWidgetTv(Widget body) {
    return ChangeNotifierProvider<TvSearchNotifier>.value(
      value: mockTvSearchNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Search Movies Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockMovieSearchNotifier.state).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(makeTestableWidgetMovie(const SearchPage(isMovie: true)));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(mockMovieSearchNotifier.state).thenReturn(RequestState.loaded);
      when(mockMovieSearchNotifier.searchResult).thenReturn(testMovieList);

      final textFieldFinder = find.byType(TextField);
      final listViewFinder = find.byType(ListView);

      await tester
          .pumpWidget(makeTestableWidgetMovie(const SearchPage(isMovie: true)));
      await tester.drag(listViewFinder, const Offset(0, -300));

      await tester.enterText(textFieldFinder, 'Search Query');
      await tester.testTextInput.receiveAction(TextInputAction.search);

      expect(find.text('Search Query'), findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Empty',
        (WidgetTester tester) async {
      when(mockMovieSearchNotifier.state).thenReturn(RequestState.empty);
      when(mockMovieSearchNotifier.message).thenReturn('No Data is found');

      final textFinder = find.text('No Data is found');

      await tester
          .pumpWidget(makeTestableWidgetMovie(const SearchPage(isMovie: true)));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockMovieSearchNotifier.state).thenReturn(RequestState.error);
      when(mockMovieSearchNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(makeTestableWidgetMovie(const SearchPage(isMovie: true)));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Search Tv Shows Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockTvSearchNotifier.state).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(makeTestableWidgetTv(const SearchPage(isMovie: false)));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(mockTvSearchNotifier.state).thenReturn(RequestState.loaded);
      when(mockTvSearchNotifier.searchResult).thenReturn(testTvList);

      final textFieldFinder = find.byType(TextField);
      final listViewFinder = find.byType(ListView);

      await tester
          .pumpWidget(makeTestableWidgetTv(const SearchPage(isMovie: false)));
      await tester.drag(listViewFinder, const Offset(0, -300));

      await tester.enterText(textFieldFinder, 'Search Query');
      await tester.testTextInput.receiveAction(TextInputAction.search);

      expect(find.text('Search Query'), findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Empty',
        (WidgetTester tester) async {
      when(mockTvSearchNotifier.state).thenReturn(RequestState.empty);
      when(mockTvSearchNotifier.message).thenReturn('No Data is found');

      final textFinder = find.text('No Data is found');

      await tester
          .pumpWidget(makeTestableWidgetTv(const SearchPage(isMovie: false)));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockTvSearchNotifier.state).thenReturn(RequestState.error);
      when(mockTvSearchNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(makeTestableWidgetTv(const SearchPage(isMovie: false)));

      expect(textFinder, findsOneWidget);
    });
  });
}
