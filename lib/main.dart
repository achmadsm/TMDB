import 'package:flutter/material.dart';
import 'package:tmdb/common/constants.dart';
import 'package:tmdb/domain/entities/detail_args.dart';
import 'package:tmdb/injection.dart' as di;
import 'package:tmdb/presentation/pages/detail_page.dart';
import 'package:tmdb/presentation/pages/home_page.dart';
import 'package:tmdb/presentation/pages/popular_page.dart';
import 'package:tmdb/presentation/pages/search_page.dart';
import 'package:tmdb/presentation/pages/top_rated_page.dart';
import 'package:tmdb/presentation/provider/movie_detail_notifier.dart';
import 'package:tmdb/presentation/provider/movie_list_notifier.dart';
import 'package:tmdb/presentation/provider/movie_search_notifier.dart';
import 'package:tmdb/presentation/provider/tv_detail_notifier.dart';
import 'package:tmdb/presentation/provider/tv_list_notifier.dart';
import 'package:tmdb/presentation/provider/tv_search_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case DetailPage.routeName:
              final args = settings.arguments as DetailArgs;
              return MaterialPageRoute(
                builder: (_) => DetailPage(args: args),
                settings: settings,
              );
            case PopularPage.routeName:
              final args = settings.arguments as bool;
              return MaterialPageRoute(
                  builder: (_) => PopularPage(isMovie: args));
            case TopRatedPage.routeName:
              final args = settings.arguments as bool;
              return MaterialPageRoute(
                  builder: (_) => TopRatedPage(isMovie: args));
            case SearchPage.routeName:
              final args = settings.arguments as bool;
              return MaterialPageRoute(
                  builder: (_) => SearchPage(isMovie: args));
            default:
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
