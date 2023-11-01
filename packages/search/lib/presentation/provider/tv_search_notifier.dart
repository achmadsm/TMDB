import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:tv/domain/entities/tv.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvShows searchTvShows;

  TvSearchNotifier({required this.searchTvShows});

  List<Tv> _searchResult = [];
  RequestState _state = RequestState.empty;
  String _message = '';

  List<Tv> get searchResult => _searchResult;

  RequestState get state => _state;

  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);

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
