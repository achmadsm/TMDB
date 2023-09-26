import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/common/constants.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    required this.posterPath,
    this.width,
  }) : super(key: key);

  final String posterPath;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '$baseImageUrl$posterPath',
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: width,
      fit: BoxFit.cover,
    );
  }
}
