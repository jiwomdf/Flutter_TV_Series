
import 'package:flutter_tv_series/di/provider_injection.dart';
import 'package:get_it/get_it.dart';

import '../domain/usecases/movie_detail_usecase.dart';
import '../domain/usecases/movie_recommendations_usecase.dart';
import '../domain/usecases/now_playing_movies_usecase.dart';
import '../domain/usecases/popular_movies_usecase.dart';
import '../domain/usecases/top_rated_movies_usecase.dart';
import '../domain/usecases/watchlist_movies_usecase.dart';
import '../domain/usecases/watchlist_status_usecase.dart';
import '../domain/usecases/remove_watchlist_usecase.dart';
import '../domain/usecases/save_watchlist_usecase.dart';
import '../domain/usecases/search_movies_usecase.dart';


void init() {
  locator.registerLazySingleton(() => NowPlayingMoviesUseCase(locator()));
  locator.registerLazySingleton(() => PopularMoviesUseCase(locator()));
  locator.registerLazySingleton(() => TopRatedMoviesUseCase(locator()));
  locator.registerLazySingleton(() => MovieDetailUseCase(locator()));
  locator.registerLazySingleton(() => MovieRecommendationsUseCase(locator()));
  locator.registerLazySingleton(() => SearchMoviesUseCase(locator()));
  locator.registerLazySingleton(() => WatchListStatusUseCase(locator()));
  locator.registerLazySingleton(() => SaveWatchlistUseCase(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistUseCase(locator()));
  locator.registerLazySingleton(() => WatchlistMoviesUseCase(locator()));
}