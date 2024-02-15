
import 'package:flutter_tv_series/di/provider_injection.dart';
import 'package:get_it/get_it.dart';

import '../domain/usecases/get_movie_detail.dart';
import '../domain/usecases/get_movie_recommendations.dart';
import '../domain/usecases/get_now_playing_movies.dart';
import '../domain/usecases/get_popular_movies.dart';
import '../domain/usecases/get_top_rated_movies.dart';
import '../domain/usecases/get_watchlist_movies.dart';
import '../domain/usecases/get_watchlist_status.dart';
import '../domain/usecases/remove_watchlist.dart';
import '../domain/usecases/save_watchlist.dart';
import '../domain/usecases/search_movies.dart';


void init() {
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
}