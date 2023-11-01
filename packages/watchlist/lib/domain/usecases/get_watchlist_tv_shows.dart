import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistTvShows {
  final WatchlistRepository repository;

  GetWatchlistTvShows(this.repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return repository.getWatchlistTvShows();
  }
}
