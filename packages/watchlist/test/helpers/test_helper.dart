import 'package:mockito/annotations.dart';
import 'package:watchlist/data/datasources/db/database_helper.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

@GenerateMocks([
  WatchlistRepository,
  WatchlistLocalDataSource,
  DatabaseHelper,
])
void main() {}
