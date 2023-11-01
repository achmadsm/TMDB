import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tv_shows.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShows usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetPopularTvShows(mockTvRpository);
  });

  group('GetPopularTvShows Tests', () {
    group('execute', () {
      test(
          'should get list of tv shows from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getPopularTvShows())
            .thenAnswer((_) async => Right(testTvList));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(testTvList));
      });
    });
  });
}
