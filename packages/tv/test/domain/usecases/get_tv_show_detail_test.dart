import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_show_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvShowDetail(mockTvRepository);
  });

  test('should get tv show detail from repository', () async {
    // arrange
    when(mockTvRepository.getTvShowDetail(1))
        .thenAnswer((_) async => const Right(testTvDetail));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, const Right(testTvDetail));
  });
}
