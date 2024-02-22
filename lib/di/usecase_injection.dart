
import 'package:flutter_tv_series/di/provider_injection.dart';
import 'package:get_it/get_it.dart';

import '../domain/usecases/get_movie_detail_usecase.dart';
import '../domain/usecases/get_movie_recommendations_usecase.dart';
import '../domain/usecases/get_now_playing_movies_usecase.dart';
import '../domain/usecases/get_popular_movies_usecase.dart';
import '../domain/usecases/get_top_rated_movies_usecase.dart';
import '../domain/usecases/get_watchlist_movies_usecase.dart';
import '../domain/usecases/get_watchlist_status_usecase.dart';
import '../domain/usecases/remove_watchlist_usecase.dart';
import '../domain/usecases/save_watchlist_usecase.dart';
import '../domain/usecases/search_movies_usecase.dart';


void init() {
  locator.registerLazySingleton(() => GetNowPlayingMoviesUseCase(locator()));
  locator.registerLazySingleton(() => GetPopularMoviesUseCase(locator()));
  locator.registerLazySingleton(() => GetTopRatedMoviesUseCase(locator()));
  locator.registerLazySingleton(() => MovieDetailUseCase(locator()));
  locator.registerLazySingleton(() => MovieRecommendationsUseCase(locator()));
  locator.registerLazySingleton(() => SearchMoviesUseCase(locator()));
  locator.registerLazySingleton(() => WatchListStatusUseCase(locator()));
  locator.registerLazySingleton(() => SaveWatchlistUseCase(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistUseCase(locator()));
  locator.registerLazySingleton(() => GetWatchlistMoviesUseCase(locator()));
}