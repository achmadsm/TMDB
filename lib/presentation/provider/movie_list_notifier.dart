import 'package:flutter/foundation.dart';
import 'package:movie_tv/common/state_enum.dart';
import 'package:movie_tv/domain/entities/movie.dart';
import 'package:movie_tv/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_tv/domain/usecases/get_popular_movies.dart';
import 'package:movie_tv/domain/usecases/get_top_rated_movies.dart';

class MovieListNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  var _nowPlayingMovies = <Movie>[];
  var _popularMovies = <Movie>[];
  var _topRatedMovies = <Movie>[];

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  List<Movie> get popularMovies => _popularMovies;

  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState _popularMoviesState = RequestState.empty;
  RequestState _topRatedMoviesState = RequestState.empty;

  RequestState get nowPlayingState => _nowPlayingState;

  RequestState get popularMoviesState => _popularMoviesState;

  RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        _popularMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
