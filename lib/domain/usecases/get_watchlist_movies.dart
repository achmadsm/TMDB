import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/watchlist.dart';
import 'package:tmdb/domain/repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository repository;

  GetWatchlistMovies(this.repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return repository.getWatchlistMovies();
  }
}
