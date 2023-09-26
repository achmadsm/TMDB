import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/tv.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';

class GetTvShowRecommendations {
  final TvRepository repository;

  GetTvShowRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvShowRecommendations(id);
  }
}
