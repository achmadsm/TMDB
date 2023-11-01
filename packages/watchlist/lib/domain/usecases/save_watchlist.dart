import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class SaveWatchList {
  final WatchlistRepository repository;

  SaveWatchList(this.repository);

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return repository.saveWatchlistMovie(movie);
  }

  Future<Either<Failure, String>> executeTv(TvDetail tv) {
    return repository.saveWatchlistTvShow(tv);
  }
}
