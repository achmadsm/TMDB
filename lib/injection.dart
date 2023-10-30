import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/data/datasources/db/database_helper.dart';
import 'package:tmdb/data/datasources/movie_local_data_source.dart';
import 'package:tmdb/data/datasources/movie_remote_data_surce.dart';
import 'package:tmdb/data/datasources/tv_local_data_source.dart';
import 'package:tmdb/data/datasources/tv_remote_data_source.dart';
import 'package:tmdb/data/repositories/movie_repository_impl.dart';
import 'package:tmdb/data/repositories/tv_repository_impl.dart';
import 'package:tmdb/domain/repositories/movie_repository.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';
import 'package:tmdb/domain/usecases/get_movie_detail.dart';
import 'package:tmdb/domain/usecases/get_movie_recommendations.dart';
import 'package:tmdb/domain/usecases/get_now_playing_movies.dart';
import 'package:tmdb/domain/usecases/get_on_the_air_tv_shows.dart';
import 'package:tmdb/domain/usecases/get_popular_movies.dart';
import 'package:tmdb/domain/usecases/get_popular_tv_shows.dart';
import 'package:tmdb/domain/usecases/get_top_rated_movies.dart';
import 'package:tmdb/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:tmdb/domain/usecases/get_tv_show_detail.dart';
import 'package:tmdb/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tmdb/domain/usecases/get_watchlist_movies.dart';
import 'package:tmdb/domain/usecases/get_watchlist_status.dart';
import 'package:tmdb/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:tmdb/domain/usecases/remove_watchlist.dart';
import 'package:tmdb/domain/usecases/save_watchlist.dart';
import 'package:tmdb/domain/usecases/search_movies.dart';
import 'package:tmdb/domain/usecases/search_tv_shows.dart';
import 'package:tmdb/presentation/provider/movie_detail_notifier.dart';
import 'package:tmdb/presentation/provider/movie_list_notifier.dart';
import 'package:tmdb/presentation/provider/movie_search_notifier.dart';
import 'package:tmdb/presentation/provider/tv_detail_notifier.dart';
import 'package:tmdb/presentation/provider/tv_list_notifier.dart';
import 'package:tmdb/presentation/provider/tv_search_notifier.dart';
import 'package:tmdb/presentation/provider/watchlist_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(() => MovieSearchNotifier(searchMovies: locator()));
  locator.registerFactory(
    () => TvListNotifier(
      getOnTheAirTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
    ),
  );
  locator.registerFactory(() => TvSearchNotifier(searchTvShows: locator()));
  locator.registerFactory(
    () => WatchlistNotifier(
      getWatchlistMovies: locator(),
      getWatchlistTvShows: locator(),
      getWatchlistStatus: locator(),
      saveWatchList: locator(),
      removeWatchList: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatus(locator(), locator()));
  locator.registerLazySingleton(() => SaveWatchList(locator(), locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator(), locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
