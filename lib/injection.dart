import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_tv/data/datasources/movie_remote_data_surce.dart';
import 'package:movie_tv/data/datasources/tv_remote_data_source.dart';
import 'package:movie_tv/data/repositories/movie_repository_impl.dart';
import 'package:movie_tv/data/repositories/tv_repository_impl.dart';
import 'package:movie_tv/domain/repositories/movie_repository.dart';
import 'package:movie_tv/domain/repositories/tv_repository.dart';
import 'package:movie_tv/domain/usecases/get_movie_detail.dart';
import 'package:movie_tv/domain/usecases/get_movie_recommendations.dart';
import 'package:movie_tv/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_tv/domain/usecases/get_on_the_air_tv_shows.dart';
import 'package:movie_tv/domain/usecases/get_popular_movies.dart';
import 'package:movie_tv/domain/usecases/get_popular_tv_shows.dart';
import 'package:movie_tv/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_tv/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:movie_tv/domain/usecases/get_tv_show_detail.dart';
import 'package:movie_tv/domain/usecases/get_tv_show_recommendations.dart';
import 'package:movie_tv/domain/usecases/search_movies.dart';
import 'package:movie_tv/domain/usecases/search_tv_shows.dart';
import 'package:movie_tv/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_tv/presentation/provider/movie_list_notifier.dart';
import 'package:movie_tv/presentation/provider/movie_search_notifier.dart';
import 'package:movie_tv/presentation/provider/tv_detail_notifier.dart';
import 'package:movie_tv/presentation/provider/tv_list_notifier.dart';
import 'package:movie_tv/presentation/provider/tv_search_notifier.dart';

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
      getTvDetail: locator(),
      getTvRecommendations: locator(),
    ),
  );
  locator.registerFactory(() => TvSearchNotifier(searchTvShows: locator()));

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

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(remoteDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvShowRemoteDataSource>(
    () => TvShowRemoteDataSourceImpl(client: locator()),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
