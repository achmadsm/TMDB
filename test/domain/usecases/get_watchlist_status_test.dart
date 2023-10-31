import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/domain/usecases/get_watchlist_status.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistStatus usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;

  setUp(() async {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistStatus(
      mockMovieRepository,
      mockTvRepository,
    );
  });

  test('should get watchlist movie status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(testId))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.executeMovie(testId);
    // assert
    expect(result, true);
  });

  test('should get watchlist tv status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlist(testId))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.executeTv(testId);
    // assert
    expect(result, true);
  });
}
