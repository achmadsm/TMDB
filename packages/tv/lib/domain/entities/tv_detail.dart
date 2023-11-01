import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  final List<int> episodeRunTime;
  final List<Genre> genres;
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;

  const TvDetail({
    required this.episodeRunTime,
    required this.genres,
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        episodeRunTime,
        genres,
        id,
        title,
        overview,
        posterPath,
        voteAverage,
      ];
}
