import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_tv/common/constants.dart';
import 'package:movie_tv/domain/entities/movie.dart';
import 'package:movie_tv/domain/entities/tv.dart';

class HomeCardList<T> extends StatelessWidget {
  const HomeCardList({Key? key, required this.items}) : super(key: key);

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
              movie.id,
              movie.posterPath ?? '-',
            );
          } else if (item is Tv) {
            final tv = item;
            return content(
              context,
              tv.id,
              tv.posterPath ?? '-',
            );
          }
          return null;
        },
        itemCount: items.length,
      ),
    );
  }

  Widget content(
    BuildContext context,
    int id,
    String posterPath,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          child: CachedNetworkImage(
            imageUrl: '$baseImageUrl$posterPath',
            placeholder: (
              context,
              url,
            ) =>
                const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (
              context,
              url,
              error,
            ) =>
                const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
