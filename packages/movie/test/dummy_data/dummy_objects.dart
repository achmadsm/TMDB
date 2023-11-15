import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:movie/data/models/movie_detail_model.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

const testQueryMovie = 'Spiderman';

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

const testMovieCache = MovieTable(
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
);

const testMovieCacheMap = {
  'id': 1,
  'title': 'title',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
