import 'package:equatable/equatable.dart';
import 'package:movie_tv/domain/entities/genre.dart';

class TvDetail extends Equatable {
  final List<int> episodeRunTime;
  final List<Genre> genres;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final double voteAverage;

  const TvDetail({
    required this.episodeRunTime,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        episodeRunTime,
        genres,
        id,
        name,
        overview,
        posterPath,
        voteAverage,
      ];
}
