import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/tv.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';

class GetTopRatedTvShows {
  final TvRepository repository;

  GetTopRatedTvShows(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvShows();
  }
}
