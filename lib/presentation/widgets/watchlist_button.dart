import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/domain/entities/movie_detail.dart';
import 'package:tmdb/domain/entities/tv_detail.dart';
import 'package:tmdb/presentation/provider/watchlist_notifier.dart';

class WatchlistButton<T> extends StatelessWidget {
  const WatchlistButton({
    Key? key,
    required this.isMovie,
    required this.isAddedWatchlist,
    required this.item,
  }) : super(key: key);

  final bool isMovie;
  final bool isAddedWatchlist;
  final T item;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final provider = Provider.of<WatchlistNotifier>(context, listen: false);

        final scaffoldMessengerState = ScaffoldMessenger.of(context);

        if (isAddedWatchlist) {
          (isMovie)
              ? await provider.removeFromWatchlistMovie(item as MovieDetail)
              : await provider.removeFromWatchlistTv(item as TvDetail);
        } else {
          (isMovie)
              ? await provider.addWatchlistMovie(item as MovieDetail)
              : await provider.addWatchlistTv(item as TvDetail);
        }

        final message = provider.watchlistMessage;

        if (message == watchlistAddSuccessMessage ||
            message == watchlistRemoveSuccessMessage) {
          scaffoldMessengerState.showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(milliseconds: 500),
            ),
          );
        } else {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(message),
              ),
            );
          }
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isAddedWatchlist ? const Icon(Icons.check) : const Icon(Icons.add),
          const Text('Watchlist'),
        ],
      ),
    );
  }
}
