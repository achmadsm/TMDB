import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late MovieDetailNotifier provider;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    provider = MovieDetailNotifier(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  void arrangeUsecase() {
    when(mockGetMovieDetail.execute(1))
        .thenAnswer((_) async => const Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(1))
        .thenAnswer((_) async => Right(testMovieList));
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchMovieDetail(1);
      // assert
      verify(mockGetMovieDetail.execute(1));
      verify(mockGetMovieRecommendations.execute(1));
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchMovieDetail(1);
      // assert
      expect(provider.movieState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchMovieDetail(1);
      // assert
      expect(provider.movieState, RequestState.loaded);
      expect(provider.movie, testMovieDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchMovieDetail(1);
      // assert
      expect(provider.movieState, RequestState.loaded);
      expect(provider.movieRecommendations, testMovieList);
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchMovieDetail(1);
      // assert
      verify(mockGetMovieRecommendations.execute(1));
      expect(provider.movieRecommendations, testMovieList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchMovieDetail(1);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.movieRecommendations, testMovieList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => const Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchMovieDetail(1);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(testMovieList));
      // act
      await provider.fetchMovieDetail(1);
      // assert
      expect(provider.movieState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
