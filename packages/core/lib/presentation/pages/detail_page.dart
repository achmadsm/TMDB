import 'package:core/domain/entities/detail_args.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/presentation/widgets/custom_image.dart';
import 'package:core/presentation/widgets/heading_text.dart';
import 'package:core/presentation/widgets/recommendation_card_list.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:watchlist/presentation/provider/watchlist_notifier.dart';
import 'package:watchlist/presentation/widgets/watchlist_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.args});

  final DetailArgs args;
  static const routeName = '/detail';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      if (widget.args.isMovie) {
        Provider.of<MovieDetailNotifier>(context, listen: false)
            .fetchMovieDetail(widget.args.id);
        Provider.of<WatchlistNotifier>(context, listen: false)
            .loadWatchlistStatusMovie(widget.args.id);
      } else {
        Provider.of<TvDetailNotifier>(context, listen: false)
            .fetchTvDetail(widget.args.id);
        Provider.of<WatchlistNotifier>(context, listen: false)
            .loadWatchlistStatusTv(widget.args.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (widget.args.isMovie) ? movie() : tvShow(),
    );
  }

  Consumer tvShow() {
    int episodeRunTime(List<int> episodeRunTime) {
      int totalRunTime = 0;
      for (var time in episodeRunTime) {
        totalRunTime += time;
      }
      return totalRunTime;
    }

    return Consumer<TvDetailNotifier>(
      builder: (context, data, child) {
        final state = data.tvState;
        if (state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.loaded) {
          final tv = data.tv;
          final isAddedToWatchlist =
              context.watch<WatchlistNotifier>().isAddedToWatchlist;

          return SafeArea(
            child: Content(
              title: tv.title,
              overview: tv.overview,
              posterPath: tv.posterPath,
              genres: tv.genres,
              runtime: episodeRunTime(tv.episodeRunTime),
              voteAverage: tv.voteAverage,
              isMovie: false,
              isAddedWatchlist: isAddedToWatchlist,
              item: tv,
            ),
          );
        } else {
          return Text(data.message);
        }
      },
    );
  }

  Consumer movie() {
    return Consumer<MovieDetailNotifier>(
      builder: (context, data, child) {
        final state = data.movieState;
        if (state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.loaded) {
          final movie = data.movie;
          final isAddedToWatchlist =
              context.watch<WatchlistNotifier>().isAddedToWatchlist;

          return SafeArea(
            child: Content(
              title: movie.title,
              overview: movie.overview,
              posterPath: movie.posterPath,
              genres: movie.genres,
              runtime: movie.runtime,
              voteAverage: movie.voteAverage,
              isMovie: true,
              isAddedWatchlist: isAddedToWatchlist,
              item: movie,
            ),
          );
        } else {
          return Text(data.message);
        }
      },
    );
  }
}

class Content<T> extends StatelessWidget {
  const Content({
    super.key,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.genres,
    required this.runtime,
    required this.voteAverage,
    required this.isMovie,
    required this.isAddedWatchlist,
    required this.item,
  });

  final String title;
  final String overview;
  final String posterPath;
  final List<Genre> genres;
  final int runtime;
  final double voteAverage;
  final bool isMovie;
  final bool isAddedWatchlist;

  final T item;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CustomImage(
          posterPath: posterPath,
          width: screenWidth,
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: kHeading5,
                            ),
                            WatchlistButton(
                              isMovie: isMovie,
                              isAddedWatchlist: isAddedWatchlist,
                              item: item,
                            ),
                            Text(
                              showGenres(genres),
                            ),
                            Text(
                              showDuration(runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('$voteAverage'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const HeadingText('Overview'),
                            Text((overview.isNotEmpty) ? overview : '-'),
                            const SizedBox(height: 16),
                            const HeadingText('Recommendations'),
                            RecommendationCardList(isMovie: isMovie),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
