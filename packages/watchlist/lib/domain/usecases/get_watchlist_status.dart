import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistStatus {
  final WatchlistRepository repository;

  GetWatchlistStatus(this.repository);

  Future<bool> executeMovie(int id) {
    return repository.isAddedToWatchlistMovie(id);
  }

  Future<bool> executeTv(int id) {
    return repository.isAddedToWatchlistTv(id);
  }
}
