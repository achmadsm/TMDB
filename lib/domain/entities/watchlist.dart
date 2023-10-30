import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final bool? isMovie;

  const Watchlist({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.isMovie,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        isMovie,
      ];
}
