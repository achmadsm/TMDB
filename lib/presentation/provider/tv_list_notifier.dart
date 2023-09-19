import 'package:flutter/foundation.dart';
import 'package:movie_tv/common/state_enum.dart';
import 'package:movie_tv/domain/entities/tv.dart';
import 'package:movie_tv/domain/usecases/get_on_the_air_tv_shows.dart';
import 'package:movie_tv/domain/usecases/get_popular_tv_shows.dart';
import 'package:movie_tv/domain/usecases/get_top_rated_tv_shows.dart';

class TvListNotifier extends ChangeNotifier {
  final GetOnTheAirTvShows getOnTheAirTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  TvListNotifier({
    required this.getOnTheAirTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  var _onTheAirTvShows = <Tv>[];
  var _popularTvShows = <Tv>[];
  var _topRatedTvShows = <Tv>[];

  List<Tv> get nowPlayingTvShows => _onTheAirTvShows;

  List<Tv> get popularTvShows => _popularTvShows;

  List<Tv> get topRatedTvShows => _topRatedTvShows;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState _popularTvShowsState = RequestState.empty;
  RequestState _topRatedTvShowsState = RequestState.empty;

  RequestState get nowPlayingState => _nowPlayingState;

  RequestState get popularTvShowsState => _popularTvShowsState;

  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlayingTvShows() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTvShows.execute();

    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _nowPlayingState = RequestState.loaded;
        _onTheAirTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();

    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _popularTvShowsState = RequestState.loaded;
        _popularTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();

    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedTvShowsState = RequestState.loaded;
        _topRatedTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
