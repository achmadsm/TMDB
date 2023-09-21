import 'package:flutter/foundation.dart';
import 'package:movie_tv/common/state_enum.dart';
import 'package:movie_tv/domain/entities/movie.dart';
import 'package:movie_tv/domain/usecases/search_movies.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;

  MovieSearchNotifier({required this.searchMovies});

  List<Movie> _searchResult = [];
  RequestState _state = RequestState.empty;
  String _message = '';

  List<Movie> get searchResult => _searchResult;

  RequestState get state => _state;

  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchMovies.execute(query);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty) {
          _message = 'No Data is found';
          _state = RequestState.empty;
          notifyListeners();
        } else {
          _searchResult = data;
          _state = RequestState.loaded;
          notifyListeners();
        }
      },
    );
  }
}
