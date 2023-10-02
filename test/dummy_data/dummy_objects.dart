import 'package:tmdb/data/models/genre_model.dart';
import 'package:tmdb/data/models/movie_detail_model.dart';
import 'package:tmdb/data/models/movie_model.dart';
import 'package:tmdb/data/models/tv_detail_model.dart';
import 'package:tmdb/data/models/tv_model.dart';
import 'package:tmdb/domain/entities/genre.dart';
import 'package:tmdb/domain/entities/movie.dart';
import 'package:tmdb/domain/entities/movie_detail.dart';
import 'package:tmdb/domain/entities/tv.dart';
import 'package:tmdb/domain/entities/tv_detail.dart';

const testId = 1;
const testQueryMovie = 'Spiderman';
const testQueryTvShow = 'Avatar';

const testMovie = Movie(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
);

const testMovieModel = MovieModel(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
);

final testMovieList = [testMovie];
final testMovieModelList = [testMovieModel];

const testMovieDetail = MovieDetail(
  genres: [Genre(id: 1, name: 'name')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  runtime: 1,
  title: 'title',
  voteAverage: 1.0,
);

const testMovieDetailModel = MovieDetailResponse(
  genres: [GenreModel(id: 1, name: 'name')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  runtime: 1,
  title: 'title',
  voteAverage: 1.0,
);

const testTv = Tv(
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
);

const testTvModel = TvModel(
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
);

final testTvList = [testTv];
final testTvModelList = [testTvModel];

const testTvDetail = TvDetail(
  episodeRunTime: [1],
  genres: [Genre(id: 1, name: 'name')],
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1.0,
);

const testTvDetailModel = TvDetailResponse(
  episodeRunTime: [1],
  genres: [GenreModel(id: 1, name: 'name')],
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1.0,
);
