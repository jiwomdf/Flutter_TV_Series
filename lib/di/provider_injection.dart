import 'package:get_it/get_it.dart';
import '../presentation/provider/movie_detail_notifier.dart';
import '../presentation/provider/movie_list_notifier.dart';
import '../presentation/provider/movie_search_notifier.dart';
import '../presentation/provider/watchlist_movie_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
        () => MovieListNotifier(
      nowPlayingMoviesUseCase: locator(),
      popularMoviesUseCase: locator(),
      topRatedMoviesUseCase: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieDetailNotifier(
      movieDetailUseCase: locator(),
      movieRecommendationsUseCase: locator(),
      watchListStatusUseCase: locator(),
      saveWatchlistUseCase: locator(),
      removeWatchlistUseCase: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieSearchNotifier(
      searchMoviesUseCase: locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMovieNotifier(
      getWatchlistMoviesUseCase: locator(),
    ),
  );
}
