import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/tv.dart';
import 'package:tmdb/domain/entities/tv_detail.dart';
import 'package:tmdb/domain/entities/watchlist.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvShows();

  Future<Either<Failure, List<Tv>>> getPopularTvShows();

  Future<Either<Failure, List<Tv>>> getTopRatedTvShows();

  Future<Either<Failure, TvDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<Tv>>> getTvShowRecommendations(int id);

  Future<Either<Failure, List<Tv>>> searchTvShows(String query);

  Future<Either<Failure, String>> saveWatchlistTvShow(TvDetail tv);

  Future<Either<Failure, String>> removeWatchlistTvShow(TvDetail tv);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<Watchlist>>> getWatchlistTvShows();
}
