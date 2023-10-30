import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/common/state_enum.dart';
import 'package:tmdb/presentation/provider/movie_search_notifier.dart';
import 'package:tmdb/presentation/provider/tv_search_notifier.dart';
import 'package:tmdb/presentation/widgets/card_item.dart';
import 'package:tmdb/presentation/widgets/heading_text.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required this.isMovie}) : super(key: key);

  final bool isMovie;

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    final String title = (isMovie) ? 'Movies' : 'Tv Shows';

    return Scaffold(
      appBar: AppBar(
        title: Text('Search $title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                (isMovie)
                    ? Provider.of<MovieSearchNotifier>(context, listen: false)
                        .fetchMovieSearch(query)
                    : Provider.of<TvSearchNotifier>(context, listen: false)
                        .fetchTvSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            const HeadingText('Search Result'),
            (isMovie) ? movies() : tvShows(),
          ],
        ),
      ),
    );
  }

  Consumer tvShows() {
    return Consumer<TvSearchNotifier>(
      builder: (context, data, child) {
        final state = data.state;
        if (state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.loaded) {
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tv = data.searchResult[index];
                return CardItem(item: tv);
              },
              itemCount: data.searchResult.length,
            ),
          );
        } else if (data.state == RequestState.empty) {
          return Expanded(
            child: Center(
              child: Text(data.message),
            ),
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
    return Consumer<MovieSearchNotifier>(
      builder: (context, data, child) {
        final state = data.state;
        if (state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.loaded) {
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = data.searchResult[index];
                return CardItem(item: movie);
              },
              itemCount: data.searchResult.length,
            ),
          );
        } else if (data.state == RequestState.empty) {
          return Expanded(
            child: Center(
              child: Text(data.message),
            ),
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
