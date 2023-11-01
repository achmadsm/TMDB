import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;

  const Tv({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
      ];
}
