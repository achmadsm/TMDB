import 'package:flutter/foundation.dart';
import 'package:movie_tv/common/state_enum.dart';
import 'package:movie_tv/domain/entities/tv.dart';
import 'package:movie_tv/domain/entities/tv_detail.dart';
import 'package:movie_tv/domain/usecases/get_tv_show_detail.dart';
import 'package:movie_tv/domain/usecases/get_tv_show_recommendations.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvShowDetail getTvDetail;
  final GetTvShowRecommendations getTvRecommendations;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
  });

  late TvDetail _tv;
  List<Tv> _tvRecommendations = [];

  TvDetail get tv => _tv;

  List<Tv> get tvRecommendations => _tvRecommendations;

  RequestState _tvState = RequestState.empty;
  RequestState _recommendationState = RequestState.empty;

  RequestState get tvState => _tvState;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationState = RequestState.loading;
        _tv = tv;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (tvShows) {
            _recommendationState = RequestState.loaded;
            _tvRecommendations = tvShows;
          },
        );
        _tvState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}