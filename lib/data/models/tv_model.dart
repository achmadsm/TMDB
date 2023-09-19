import 'package:equatable/equatable.dart';
import 'package:movie_tv/domain/entities/tv.dart';

class TvModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;

  const TvModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
      };

  Tv toEntity() {
    return Tv(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
      ];
}
