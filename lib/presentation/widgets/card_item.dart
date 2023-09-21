import 'package:flutter/material.dart';
import 'package:movie_tv/common/constants.dart';
import 'package:movie_tv/domain/entities/movie.dart';
import 'package:movie_tv/domain/entities/tv.dart';
import 'package:movie_tv/presentation/widgets/custom_image.dart';

class CardItem<T> extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final T item;

  @override
  Widget build(BuildContext context) {
    if (item is Movie) {
      final movie = item as Movie;
      return content(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath ?? '-',
      );
    } else if (item is Tv) {
      final tv = item as Tv;
      return content(
        id: tv.id,
        title: tv.name,
        overview: tv.overview,
        posterPath: tv.posterPath ?? '-',
      );
    }
    return const SizedBox();
  }

  Container content({
    required int id,
    required String title,
    required String overview,
    required String posterPath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                left: 16 + 80 + 16,
                bottom: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (title.isEmpty) ? '-' : title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    (overview.isEmpty) ? '-' : overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              bottom: 16,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: CustomImage(
                posterPath: posterPath,
                width: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
