import 'package:dartz/dartz.dart';
import 'package:movie_tv/common/failure.dart';
import 'package:movie_tv/domain/entities/movie.dart';
import 'package:movie_tv/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
