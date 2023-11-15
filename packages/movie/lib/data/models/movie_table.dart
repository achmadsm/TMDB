import 'package:equatable/equatable.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

class MovieTable extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;

  const MovieTable({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        overview: map['overview'],
        posterPath: map['posterPath'],
      );

  factory MovieTable.fromDTO(MovieModel movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'posterPath': posterPath,
      };

  Movie toEntity() => Movie(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
      ];
}
