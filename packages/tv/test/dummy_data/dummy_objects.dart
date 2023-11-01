import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

const testQueryTvShow = 'Avatar';

const testTv = Tv(
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
);

const testTvModel = TvModel(
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
);

final testTvList = [testTv];
final testTvModelList = [testTvModel];

const testTvDetail = TvDetail(
  episodeRunTime: [1],
  genres: [Genre(id: 1, name: 'name')],
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1.0,
);

const testTvDetailModel = TvDetailResponse(
  episodeRunTime: [1],
  genres: [GenreModel(id: 1, name: 'name')],
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1.0,
);
