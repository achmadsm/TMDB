import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/movie_detail.dart';
import 'package:tmdb/domain/entities/tv_detail.dart';
import 'package:tmdb/domain/repositories/movie_repository.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';

class RemoveWatchlist {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  RemoveWatchlist(this.movieRepository, this.tvRepository);

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return movieRepository.removeWatchlistMovie(movie);
  }

  Future<Either<Failure, String>> executeTv(TvDetail tv) {
    return tvRepository.removeWatchlistTvShow(tv);
  }
}
