import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb/data/models/genre_model.dart';
import 'package:tmdb/domain/entities/genre.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  const tGenre = Genre(
    id: 1,
    name: 'name',
  );

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
}
