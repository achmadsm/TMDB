import 'package:dartz/dartz.dart';
import 'package:movie_tv/common/failure.dart';
import 'package:movie_tv/domain/entities/tv_detail.dart';
import 'package:movie_tv/domain/repositories/tv_repository.dart';

class GetTvShowDetail {
  final TvRepository repository;

  GetTvShowDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}
