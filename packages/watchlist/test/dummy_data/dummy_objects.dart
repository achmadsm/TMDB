import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

const testWatchlistMovie = Watchlist(
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
  isMovie: true,
);

const testWatchlistMovieList = [testWatchlistMovie];

const testMovieTable = WatchlistTable(
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
  isMovie: 1,
);

final testMovieMap = {
  'id': 1,
  'title': 'title',
  'overview': 'overview',
  'posterPath': 'posterPath',
  'isMovie': 1,
};

const testWatchlistTv = Watchlist(
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
  isMovie: false,
);

const testWatchlistTvList = [testWatchlistTv];

const testTvTable = WatchlistTable(
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
  isMovie: 0,
);

final testTvMap = {
  'id': 1,
  'title': 'title',
  'overview': 'overview',
  'posterPath': 'posterPath',
  'isMovie': 0,
};
