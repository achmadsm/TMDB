import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/tv.dart';
import 'package:tmdb/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvShows();

  Future<Either<Failure, List<Tv>>> getPopularTvShows();

  Future<Either<Failure, List<Tv>>> getTopRatedTvShows();

  Future<Either<Failure, TvDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<Tv>>> getTvShowRecommendations(int id);

  Future<Either<Failure, List<Tv>>> searchTvShows(String query);
}
