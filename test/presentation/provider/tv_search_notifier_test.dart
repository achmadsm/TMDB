import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/common/state_enum.dart';
import 'package:tmdb/domain/usecases/search_tv_shows.dart';
import 'package:tmdb/presentation/provider/tv_search_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late TvSearchNotifier provider;
  late MockSearchTvShows mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShows = MockSearchTvShows();
    provider = TvSearchNotifier(searchTvShows: mockSearchTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('search tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvShows.execute(testQueryTvShow))
          .thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTvSearch(testQueryTvShow);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change state to empty when no data is found', () async {
      // arrange
      when(mockSearchTvShows.execute(testQueryTvShow))
          .thenAnswer((_) async => const Right([]));
      // act
      await provider.fetchTvSearch(testQueryTvShow);
      // assert
      expect(provider.state, RequestState.empty);
      expect(provider.message, 'No Data is found');
      expect(listenerCallCount, 2);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShows.execute(testQueryTvShow))
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchTvSearch(testQueryTvShow);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchResult, testTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(testQueryTvShow))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSearch(testQueryTvShow);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
