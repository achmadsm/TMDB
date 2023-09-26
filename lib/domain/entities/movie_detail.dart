import 'package:equatable/equatable.dart';
import 'package:tmdb/domain/entities/genre.dart';

class MovieDetail extends Equatable {
  final List<Genre> genres;
  final int id;
  final String overview;
  final String posterPath;
  final int runtime;
  final String title;
  final double voteAverage;

  const MovieDetail({
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.runtime,
    required this.title,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        genres,
        id,
        overview,
        posterPath,
        runtime,
        title,
        voteAverage,
      ];
}
