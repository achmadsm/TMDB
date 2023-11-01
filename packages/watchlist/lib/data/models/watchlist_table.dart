import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final int? isMovie;

  const WatchlistTable({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.isMovie,
  });

  factory WatchlistTable.fromMovieEntity(MovieDetail movie) => WatchlistTable(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
        isMovie: 1,
      );

  factory WatchlistTable.fromTvEntity(TvDetail tv) => WatchlistTable(
        id: tv.id,
        title: tv.title,
        overview: tv.overview,
        posterPath: tv.posterPath,
        isMovie: 0,
      );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
        id: map['id'],
        title: map['title'],
        overview: map['overview'],
        posterPath: map['posterPath'],
        isMovie: map['isMovie'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'posterPath': posterPath,
        'isMovie': isMovie,
      };

  Watchlist toEntity() => Watchlist(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        isMovie: isMovie == 1,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        isMovie,
      ];
}
