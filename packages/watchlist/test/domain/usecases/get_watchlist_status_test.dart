import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistStatus usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() async {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlistStatus(mockWatchlistRepository);
  });

  test('should get watchlist movie status from repository', () async {
    // arrange
    when(mockWatchlistRepository.isAddedToWatchlistMovie(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.executeMovie(1);
    // assert
    expect(result, true);
  });

  test('should get watchlist tv status from repository', () async {
    // arrange
    when(mockWatchlistRepository.isAddedToWatchlistTv(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.executeTv(1);
    // assert
    expect(result, true);
  });
}
