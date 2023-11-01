import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistMovies {
  final WatchlistRepository repository;

  GetWatchlistMovies(this.repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return repository.getWatchlistMovies();
  }
}
