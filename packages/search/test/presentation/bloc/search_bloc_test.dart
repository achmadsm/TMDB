import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late SearchTvShowsBloc searchTvShowsBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTvShows;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTvShows();
    searchMoviesBloc = SearchMoviesBloc(mockSearchMovies);
    searchTvShowsBloc = SearchTvShowsBloc(mockSearchTvShows);
  });

  group('Search Movies', () {
    test('initial state should be initial', () {
      expect(searchMoviesBloc.state, SearchInitial());
    });

    blocTest<SearchMoviesBloc, SearchState>(
      'Should emit [Loading, Empty] when no data is found',
      build: () {
        when(mockSearchMovies.execute(testQueryMovie))
            .thenAnswer((_) async => const Right([]));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(testQueryMovie)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchEmpty('No Data is found'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(testQueryMovie));
      },
    );

    blocTest<SearchMoviesBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(testQueryMovie))
            .thenAnswer((_) async => Right(testMovieList));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(testQueryMovie)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(testQueryMovie));
      },
    );

    blocTest<SearchMoviesBloc, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(testQueryMovie)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(testQueryMovie)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(testQueryMovie));
      },
    );
  });

  group('Search Tv Shows', () {
    test('initial state should be initial', () {
      expect(searchTvShowsBloc.state, SearchInitial());
    });

    blocTest<SearchTvShowsBloc, SearchState>(
      'Should emit [Loading, Empty] when no data is found',
      build: () {
        when(mockSearchTvShows.execute(testQueryTvShow))
            .thenAnswer((_) async => const Right([]));
        return searchTvShowsBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(testQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchEmpty('No Data is found'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(testQueryTvShow));
      },
    );

    blocTest<SearchTvShowsBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvShows.execute(testQueryTvShow))
            .thenAnswer((_) async => Right(testTvList));
        return searchTvShowsBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(testQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(testQueryTvShow));
      },
    );

    blocTest<SearchTvShowsBloc, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvShows.execute(testQueryTvShow)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchTvShowsBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(testQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(testQueryTvShow));
      },
    );
  });
}
