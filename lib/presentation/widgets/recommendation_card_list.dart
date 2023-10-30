import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/common/state_enum.dart';
import 'package:tmdb/domain/entities/detail_args.dart';
import 'package:tmdb/presentation/pages/detail_page.dart';
import 'package:tmdb/presentation/provider/movie_detail_notifier.dart';
import 'package:tmdb/presentation/provider/tv_detail_notifier.dart';
import 'package:tmdb/presentation/widgets/custom_image.dart';

class RecommendationCardList extends StatelessWidget {
  const RecommendationCardList({Key? key, required this.isMovie})
      : super(key: key);

  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return (isMovie) ? movieRecommendations() : tvRecommendations();
  }

  Consumer tvRecommendations() {
    return Consumer<TvDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.recommendationState == RequestState.loaded) {
          return (data.tvRecommendations.isNotEmpty)
              ? SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final tv = data.tvRecommendations[index];
                      return RecommendationCard(
                        id: tv.id,
                        posterPath: tv.posterPath,
                        isMovie: isMovie,
                      );
                    },
                    itemCount: data.tvRecommendations.length,
                  ),
                )
              : const Text('-');
        } else if (data.recommendationState == RequestState.error) {
          return Text(data.message);
        } else {
          return Container();
        }
      },
    );
  }

  Consumer movieRecommendations() {
    return Consumer<MovieDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.recommendationState == RequestState.loaded) {
          return (data.movieRecommendations.isNotEmpty)
              ? SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = data.movieRecommendations[index];
                      return RecommendationCard(
                        id: movie.id,
                        posterPath: movie.posterPath,
                        isMovie: isMovie,
                      );
                    },
                    itemCount: data.movieRecommendations.length,
                  ),
                )
              : const Text('-');
        } else if (data.recommendationState == RequestState.error) {
          return Text(data.message);
        } else {
          return Container();
        }
      },
    );
  }
}

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.id,
    this.posterPath,
    required this.isMovie,
  });

  final int id;
  final String? posterPath;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            DetailPage.routeName,
            arguments: DetailArgs(
              id: id,
              isMovie: isMovie,
            ),
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: CustomImage(posterPath: posterPath ?? '-'),
        ),
      ),
    );
  }
}
