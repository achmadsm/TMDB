import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

class MovieDetailNotifier extends ChangeNotifier {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  });

  late MovieDetail _movie;
  List<Movie> _movieRecommendations = [];

  MovieDetail get movie => _movie;

  List<Movie> get movieRecommendations => _movieRecommendations;

  RequestState _movieState = RequestState.empty;
  RequestState _recommendationState = RequestState.empty;

  RequestState get movieState => _movieState;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.loading;
    notifyListeners();

    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _movieState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.loading;
        _movie = movie;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
