import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_show_detail.dart';
import 'package:tv/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    provider = TvDetailNotifier(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  void arrangeUsecase() {
    when(mockGetTvShowDetail.execute(1))
        .thenAnswer((_) async => const Right(testTvDetail));
    when(mockGetTvShowRecommendations.execute(1))
        .thenAnswer((_) async => Right(testTvList));
  }

  group('Get Tv Show Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(1);
      // assert
      verify(mockGetTvShowDetail.execute(1));
      verify(mockGetTvShowRecommendations.execute(1));
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchTvDetail(1);
      // assert
      expect(provider.tvState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(1);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv shows when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(1);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tvRecommendations, testTvList);
    });
  });

  group('Get Tv Show Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(1);
      // assert
      verify(mockGetTvShowRecommendations.execute(1));
      expect(provider.tvRecommendations, testTvList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(1);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.tvRecommendations, testTvList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(1))
          .thenAnswer((_) async => const Right(testTvDetail));
      when(mockGetTvShowRecommendations.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvDetail(1);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetTvShowRecommendations.execute(1))
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchTvDetail(1);
      // assert
      expect(provider.tvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
