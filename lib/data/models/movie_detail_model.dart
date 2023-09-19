import 'package:equatable/equatable.dart';
import 'package:movie_tv/data/models/genre_model.dart';
import 'package:movie_tv/domain/entities/movie_detail.dart';

class MovieDetailResponse extends Equatable {
  final List<GenreModel> genres;
  final int id;
  final String overview;
  final String posterPath;
  final int runtime;
  final String title;
  final double voteAverage;

  const MovieDetailResponse({
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.runtime,
    required this.title,
    required this.voteAverage,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse(
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        runtime: json["runtime"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "runtime": runtime,
        "title": title,
        "vote_average": voteAverage,
      };

  MovieDetail toEntity() {
    return MovieDetail(
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      overview: overview,
      posterPath: posterPath,
      runtime: runtime,
      title: title,
      voteAverage: voteAverage,
    );
  }

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
