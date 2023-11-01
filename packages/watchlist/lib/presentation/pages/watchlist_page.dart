import 'package:core/presentation/widgets/card_item.dart';
import 'package:core/utils/route.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/presentation/provider/watchlist_notifier.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  static const routeName = '/watchlist';

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    Future.microtask(
      () => Provider.of<WatchlistNotifier>(context, listen: false)
        ..fetchWatchlistMovies()
        ..fetchWatchlistTvShows(),
    );
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistNotifier>(context, listen: false)
      ..fetchWatchlistMovies()
      ..fetchWatchlistTvShows();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const myTabs = [
      Tab(
        icon: Icon(Icons.movie),
        text: 'Movies',
      ),
      Tab(
        icon: Icon(Icons.live_tv),
        text: 'Tv Shows',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _controller,
          tabs: myTabs,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          controller: _controller,
          children: [
            movies(),
            tvShows(),
          ],
        ),
      ),
    );
  }

  Consumer movies() {
    return Consumer<WatchlistNotifier>(
      builder: (context, data, child) {
        if (data.watchlistMovieState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistMovieState == RequestState.loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.watchlistMovies[index];
              return CardItem(item: movie);
            },
            itemCount: data.watchlistMovies.length,
          );
        } else if (data.watchlistMovieState == RequestState.empty) {
          return const Center(
            child: Text('Empty'),
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

  Consumer tvShows() {
    return Consumer<WatchlistNotifier>(
      builder: (context, data, child) {
        if (data.watchlistTvState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistTvState == RequestState.loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.watchlistTvShows[index];
              return CardItem(item: movie);
            },
            itemCount: data.watchlistTvShows.length,
          );
        } else if (data.watchlistTvState == RequestState.empty) {
          return const Center(
            child: Text('Empty'),
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
