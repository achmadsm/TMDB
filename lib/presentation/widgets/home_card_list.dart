import 'package:flutter/material.dart';
import 'package:movie_tv/domain/entities/detail_args.dart';
import 'package:movie_tv/domain/entities/movie.dart';
import 'package:movie_tv/domain/entities/tv.dart';
import 'package:movie_tv/presentation/pages/detail_page.dart';

import 'custom_image.dart';

class HomeCardList<T> extends StatelessWidget {
  const HomeCardList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (
          context,
          index,
        ) {
          final item = items[index];
          if (item is Movie) {
            final movie = item;
            return content(
              context,
              id: movie.id,
              posterPath: movie.posterPath ?? '-',
              isMovie: true,
            );
          } else if (item is Tv) {
            final tv = item;
            return content(
              context,
              id: tv.id,
              posterPath: tv.posterPath ?? '-',
              isMovie: false,
            );
          }
          return null;
        },
        itemCount: items.length,
      ),
    );
  }

  Widget content(
    BuildContext context, {
    required int id,
    required String posterPath,
    required bool isMovie,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: DetailArgs(
            id: id,
            isMovie: isMovie,
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          child: CustomImage(posterPath: posterPath),
        ),
      ),
    );
  }
}
