import 'package:flutter/foundation.dart';
import 'package:tmdb/common/state_enum.dart';
import 'package:tmdb/domain/entities/movie_detail.dart';
import 'package:tmdb/domain/entities/tv_detail.dart';
import 'package:tmdb/domain/entities/watchlist.dart';
import 'package:tmdb/domain/usecases/get_watchlist_movies.dart';
import 'package:tmdb/domain/usecases/get_watchlist_status.dart';
import 'package:tmdb/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:tmdb/domain/usecases/remove_watchlist.dart';
import 'package:tmdb/domain/usecases/save_watchlist.dart';

class WatchlistNotifier extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvShows getWatchlistTvShows;
  final GetWatchlistStatus getWatchlistStatus;
  final SaveWatchList saveWatchList;
  final RemoveWatchlist removeWatchList;

  WatchlistNotifier({
    required this.getWatchlistMovies,
    required this.getWatchlistTvShows,
    required this.getWatchlistStatus,
    required this.saveWatchList,
    required this.removeWatchList,
  });

  var _watchlistMovies = <Watchlist>[];
  var _watchlistTvShows = <Watchlist>[];
  var _watchlistMovieState = RequestState.empty;
  var _watchlistTvState = RequestState.empty;
  bool _isAddedToWatchlist = false;
  String _watchlistMessage = '';
  String _message = '';

  get watchlistMovies => _watchlistMovies;

  get watchlistTvShows => _watchlistTvShows;

  get watchlistMovieState => _watchlistMovieState;

  get watchlistTvState => _watchlistTvState;

  bool get isAddedToWatchlist => _isAddedToWatchlist;

  String get watchlistMessage => _watchlistMessage;

  String get message => _message;

  Future<void> addWatchlistMovie(MovieDetail movie) async {
    final result = await saveWatchList.executeMovie(movie);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadWatchlistStatusMovie(movie.id);
  }

  Future<void> addWatchlistTv(TvDetail tv) async {
    final result = await saveWatchList.executeTv(tv);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> removeFromWatchlistMovie(MovieDetail movie) async {
    final result = await removeWatchList.executeMovie(movie);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadWatchlistStatusMovie(movie.id);
  }

  Future<void> removeFromWatchlistTv(TvDetail tv) async {
    final result = await removeWatchList.executeTv(tv);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> loadWatchlistStatusMovie(int id) async {
    final result = await getWatchlistStatus.executeMovie(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }

  Future<void> loadWatchlistStatusTv(int id) async {
    final result = await getWatchlistStatus.executeTv(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }

  Future<void> fetchWatchlistMovies() async {
    _watchlistMovieState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        _watchlistMovieState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        if (moviesData.isEmpty) {
          _watchlistMovieState = RequestState.empty;
        } else {
          _watchlistMovieState = RequestState.loaded;
        }
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvShows() async {
    _watchlistTvState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();

    result.fold(
      (failure) {
        _watchlistTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        if (tvShowsData.isEmpty) {
          _watchlistTvState = RequestState.empty;
        } else {
          _watchlistTvState = RequestState.loaded;
        }
        _watchlistTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
