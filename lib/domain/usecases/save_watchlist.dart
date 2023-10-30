import 'package:dartz/dartz.dart';
import 'package:tmdb/common/failure.dart';
import 'package:tmdb/domain/entities/movie_detail.dart';
import 'package:tmdb/domain/entities/tv_detail.dart';
import 'package:tmdb/domain/repositories/movie_repository.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';

class SaveWatchList {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  SaveWatchList(this.movieRepository, this.tvRepository);

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return movieRepository.saveWatchlistMovie(movie);
  }

  Future<Either<Failure, String>> executeTv(TvDetail tv) {
    return tvRepository.saveWatchlistTvShow(tv);
  }
}
