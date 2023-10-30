import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/watchlist.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';

class GetWatchlistTvShows {
  final TvRepository repository;

  GetWatchlistTvShows(this.repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return repository.getWatchlistTvShows();
  }
}
