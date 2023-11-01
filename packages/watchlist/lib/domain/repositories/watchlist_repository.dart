import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, String>> saveWatchlistMovie(MovieDetail movie);

  Future<Either<Failure, String>> saveWatchlistTvShow(TvDetail tv);

  Future<Either<Failure, String>> removeWatchlistMovie(MovieDetail movie);

  Future<Either<Failure, String>> removeWatchlistTvShow(TvDetail tv);

  Future<bool> isAddedToWatchlistMovie(int id);

  Future<bool> isAddedToWatchlistTv(int id);

  Future<Either<Failure, List<Watchlist>>> getWatchlistMovies();

  Future<Either<Failure, List<Watchlist>>> getWatchlistTvShows();
}
