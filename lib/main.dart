import 'package:flutter/material.dart';
import 'package:movie_tv/common/constants.dart';
import 'package:movie_tv/injection.dart' as di;
import 'package:movie_tv/presentation/pages/home_page.dart';
import 'package:movie_tv/presentation/pages/popular_page.dart';
import 'package:movie_tv/presentation/pages/top_rated_page.dart';
import 'package:movie_tv/presentation/provider/movie_list_notifier.dart';
import 'package:movie_tv/presentation/provider/tv_list_notifier.dart';
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
          final args = settings.arguments as bool;

          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => PopularPage(isMovie: args));
            case TopRatedPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => TopRatedPage(isMovie: args));
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
