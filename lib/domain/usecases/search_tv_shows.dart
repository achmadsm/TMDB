import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/tv.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';

class SearchTvShows {
  final TvRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}
