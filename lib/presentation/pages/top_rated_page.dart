import 'package:flutter/material.dart';
import 'package:movie_tv/common/state_enum.dart';
import 'package:movie_tv/presentation/provider/movie_list_notifier.dart';
import 'package:movie_tv/presentation/provider/tv_list_notifier.dart';
import 'package:movie_tv/presentation/widgets/card_item.dart';
import 'package:provider/provider.dart';

class TopRatedPage extends StatelessWidget {
  const TopRatedPage({Key? key, required this.isMovie}) : super(key: key);

  final bool isMovie;
  static const routeName = '/top-rated';

  @override
  Widget build(BuildContext context) {
    final String title = (isMovie) ? 'Movies' : 'Tv Shows';

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated $title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (isMovie) ? movies() : tvShows(),
      ),
    );
  }

  Consumer tvShows() {
    return Consumer<TvListNotifier>(
      builder: (context, data, child) {
        final state = data.topRatedTvShowsState;
        if (state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.loaded) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final tv = data.topRatedTvShows[index];
              return CardItem(item: tv);
            },
            itemCount: data.topRatedTvShows.length,
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }

  Consumer movies() {
    return Consumer<MovieListNotifier>(
      builder: (context, data, child) {
        final state = data.topRatedMoviesState;
        if (state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.loaded) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final movie = data.topRatedMovies[index];
              return CardItem(item: movie);
            },
            itemCount: data.topRatedMovies.length,
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }
}
