import 'package:tmdb/domain/repositories/movie_repository.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';

class GetWatchlistStatus {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  GetWatchlistStatus(this.movieRepository, this.tvRepository);

  Future<bool> executeMovie(int id) {
    return movieRepository.isAddedToWatchlist(id);
  }

  Future<bool> executeTv(int id) {
    return tvRepository.isAddedToWatchlist(id);
  }
}
