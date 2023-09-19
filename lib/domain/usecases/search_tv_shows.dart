import 'package:dartz/dartz.dart';
import 'package:movie_tv/common/failure.dart';
import 'package:movie_tv/domain/entities/tv.dart';
import 'package:movie_tv/domain/repositories/tv_repository.dart';

class SearchTvShows {
  final TvRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}