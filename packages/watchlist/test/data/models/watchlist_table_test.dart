import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

void main() {
  const tWatchlistTable = WatchlistTable(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
    isMovie: 1,
  );

  const tWatchlist = Watchlist(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
    isMovie: true,
  );

  test('should be a subclass of Watchlist entity', () {
    final result = tWatchlistTable.toEntity();
    expect(result, tWatchlist);
  });
}
