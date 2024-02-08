import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';

class SearchEventFake extends Fake implements SearchEvent {}

class SearchStateFake extends Fake implements SearchState {}

class MockSearchMoviesBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchMoviesBloc {}

class MockSearchTvShowsBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchTvShowsBloc {}

void main() {
  late MockSearchMoviesBloc mockSearchMoviesBloc;
  late MockSearchTvShowsBloc mockSearchTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(SearchEventFake());
    registerFallbackValue(SearchStateFake());
  });

  setUp(() {
    mockSearchMoviesBloc = MockSearchMoviesBloc();
    mockSearchTvShowsBloc = MockSearchTvShowsBloc();
  });

  Widget makeTestableWidgetMovie(Widget body) {
    return BlocProvider<SearchMoviesBloc>.value(
      value: mockSearchMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget makeTestableWidgetTv(Widget body) {
    return BlocProvider<SearchTvShowsBloc>.value(
      value: mockSearchTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Search Movies Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(makeTestableWidgetMovie(const SearchPage(isMovie: true)));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(SearchHasData(testMovieList));

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
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(const SearchEmpty('No Data is found'));

      final textFinder = find.text('No Data is found');

      await tester
          .pumpWidget(makeTestableWidgetMovie(const SearchPage(isMovie: true)));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(const SearchError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(makeTestableWidgetMovie(const SearchPage(isMovie: true)));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Search Tv Shows Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockSearchTvShowsBloc.state).thenReturn(SearchLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(makeTestableWidgetTv(const SearchPage(isMovie: false)));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockSearchTvShowsBloc.state)
          .thenReturn(SearchHasData(testTvList));

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
      when(() => mockSearchTvShowsBloc.state)
          .thenReturn(const SearchEmpty('No Data is found'));

      final textFinder = find.text('No Data is found');

      await tester
          .pumpWidget(makeTestableWidgetTv(const SearchPage(isMovie: false)));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockSearchTvShowsBloc.state)
          .thenReturn(const SearchError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(makeTestableWidgetTv(const SearchPage(isMovie: false)));

      expect(textFinder, findsOneWidget);
    });
  });
}
