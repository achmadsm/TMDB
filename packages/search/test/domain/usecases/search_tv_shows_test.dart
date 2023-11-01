import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';

import '../../../../tv/test/dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockSearchRepository mockSearchRepository;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    usecase = SearchTvShows(mockSearchRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockSearchRepository.searchTvShows(testQueryTvShow))
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute(testQueryTvShow);
    // assert
    expect(result, Right(testTvList));
  });
}
