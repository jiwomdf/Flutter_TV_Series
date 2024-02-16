import 'package:flutter/material.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

class MovieListProvider extends ChangeNotifier {

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListProvider({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  SealedState<List<Movie>> _nowPlayingState = LoadingState();
  SealedState<List<Movie>> get nowPlayingState => _nowPlayingState;

  SealedState<List<Movie>> _popularMoviesState = LoadingState();
  SealedState<List<Movie>> get popularMoviesState => _popularMoviesState;

  SealedState<List<Movie>> _topRatedMoviesState = LoadingState();
  SealedState<List<Movie>> get topRatedMoviesState => _topRatedMoviesState;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = SealedState.loading();
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _nowPlayingState = SealedState.error(failure.message);
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = SealedState.success(moviesData);
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = SealedState.loading();
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = SealedState.error(failure.message);
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = SealedState.success(moviesData);
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = SealedState.loading();
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = SealedState.error(failure.message);
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = SealedState.success(moviesData);
        notifyListeners();
      },
    );
  }
}
