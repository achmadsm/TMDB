import 'package:core/presentation/widgets/card_item.dart';
import 'package:core/presentation/widgets/heading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, required this.isMovie});

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
              onChanged: (query) {
                (isMovie)
                    ? context
                        .read<SearchMoviesBloc>()
                        .add(OnQueryChanged(query))
                    : context
                        .read<SearchTvShowsBloc>()
                        .add(OnQueryChanged(query));
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

  BlocBuilder tvShows() {
    return BlocBuilder<SearchTvShowsBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tv = result[index];
                return CardItem(item: tv);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchEmpty) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is SearchError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Expanded(child: Container());
        }
      },
    );
  }

  BlocBuilder movies() {
    return BlocBuilder<SearchMoviesBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return CardItem(item: movie);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchEmpty) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is SearchError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Expanded(child: Container());
        }
      },
    );
  }
}
