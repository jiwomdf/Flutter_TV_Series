import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv_series/presentation/pages/detail/movie_detail_screen.dart';
import 'package:flutter_tv_series/presentation/pages/home/home_movie_screen.dart';
import 'package:flutter_tv_series/presentation/pages/watchlist/watchlist_movies_screen.dart';
import 'package:flutter_tv_series/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter_tv_series/presentation/provider/movie_list_notifier.dart';
import 'package:flutter_tv_series/presentation/provider/movie_search_notifier.dart';
import 'package:flutter_tv_series/presentation/provider/watchlist_movie_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'common/utils.dart';
import 'di/datasource_injection.dart' as datasourceDi;
import 'di/provider_injection.dart' as providerDi;
import 'di/repository_injection.dart' as repositoryDi;
import 'di/usecase_injection.dart' as useCaseDi;
import 'presentation/pages/search/search_screen.dart';

void main() {
  datasourceDi.init();
  providerDi.init();
  repositoryDi.init();
  useCaseDi.init();
  runApp(const MyHomePage(title: "TV Series"));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => providerDi.locator<MovieListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => providerDi.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => providerDi.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => providerDi.locator<WatchlistMovieNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'TV Series',
        theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(
              Theme.of(context).textTheme
            )
        ),
        themeMode: ThemeMode.system,
        home: HomeMovieScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMovieScreen());
            case MovieDetailScreen.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailScreen(id: id),
                settings: settings,
              );
            case SearchScreen.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchScreen());
            case WatchlistMoviesScreen.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesScreen());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
