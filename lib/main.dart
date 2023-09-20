import 'package:flutter/material.dart';
import 'package:movie_tv/common/constants.dart';
import 'package:movie_tv/injection.dart' as di;
import 'package:movie_tv/presentation/pages/home_page.dart';
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
      ),
    );
  }
}
