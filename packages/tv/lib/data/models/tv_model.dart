import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';

class TvModel extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;

  const TvModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        id: json["id"],
        title: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": title,
        "overview": overview,
        "poster_path": posterPath,
      };

  Tv toEntity() {
    return Tv(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
      ];
}
