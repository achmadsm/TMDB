import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvShows();

  Future<Either<Failure, List<Tv>>> getPopularTvShows();

  Future<Either<Failure, List<Tv>>> getTopRatedTvShows();

  Future<Either<Failure, TvDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<Tv>>> getTvShowRecommendations(int id);
}
