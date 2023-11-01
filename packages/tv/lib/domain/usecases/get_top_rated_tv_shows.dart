import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTopRatedTvShows {
  final TvRepository repository;

  GetTopRatedTvShows(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvShows();
  }
}
