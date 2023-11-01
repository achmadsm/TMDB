import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockSearchRepository mockSearchRepository;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    usecase = SearchMovies(mockSearchRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockSearchRepository.searchMovies(testQueryMovie))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute(testQueryMovie);
    // assert
    expect(result, Right(testMovieList));
  });
}
