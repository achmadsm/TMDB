import 'package:core/domain/entities/detail_args.dart';
import 'package:core/presentation/pages/detail_page.dart';
import 'package:core/presentation/widgets/custom_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

class CardItem<T> extends StatelessWidget {
  const CardItem({super.key, required this.item});

  final T item;

  @override
  Widget build(BuildContext context) {
    if (item is Movie) {
      final movie = item as Movie;
      return content(
        context,
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath ?? '-',
        isMovie: true,
      );
    } else if (item is Tv) {
      final tv = item as Tv;
      return content(
        context,
        id: tv.id,
        title: tv.title,
        overview: tv.overview,
        posterPath: tv.posterPath ?? '-',
        isMovie: false,
      );
    } else {
      final watchlist = item as Watchlist;
      return content(
        context,
        id: watchlist.id,
        title: watchlist.title,
        overview: watchlist.overview,
        posterPath: watchlist.posterPath ?? '-',
        isMovie: watchlist.isMovie ?? true,
      );
    }
  }

  Container content(
    BuildContext context, {
    required int id,
    required String title,
    required String overview,
    required String posterPath,
    required bool isMovie,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: DetailArgs(
            id: id,
            isMovie: isMovie,
          ),
        ),
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
      ),
    );
  }
}
