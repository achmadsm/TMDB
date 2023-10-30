import 'package:tmdb/common/constants.dart';
import 'package:tmdb/common/exception.dart';
import 'package:tmdb/data/datasources/db/database_helper.dart';
import 'package:tmdb/data/models/watchlist_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable tv);

  Future<String> removeWatchlist(WatchlistTable tv);

  Future<WatchlistTable?> getTvById(int id);

  Future<List<WatchlistTable>> getWatchlistTvShows();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return watchlistAddSuccessMessage;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return watchlistRemoveSuccessMessage;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }
}
