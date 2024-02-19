import 'package:get_it/get_it.dart';
import '../presentation/provider/movie_detail_notifier.dart';
import '../presentation/provider/movie_list_notifier.dart';
import '../presentation/provider/movie_search_notifier.dart';
import '../presentation/provider/watchlist_movie_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
        () => MovieListProvider(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
}
