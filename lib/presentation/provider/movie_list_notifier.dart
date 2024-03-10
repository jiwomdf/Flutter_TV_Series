import 'package:flutter/material.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/now_playing_movies_usecase.dart';
import '../../domain/usecases/popular_movies_usecase.dart';
import '../../domain/usecases/top_rated_movies_usecase.dart';

class MovieListNotifier extends ChangeNotifier {

  final NowPlayingMoviesUseCase nowPlayingMoviesUseCase;
  final PopularMoviesUseCase popularMoviesUseCase;
  final TopRatedMoviesUseCase topRatedMoviesUseCase;

  MovieListNotifier({
    required this.nowPlayingMoviesUseCase,
    required this.popularMoviesUseCase,
    required this.topRatedMoviesUseCase,
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

    final result = await nowPlayingMoviesUseCase.getNowPlayingMovies();
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

    final result = await popularMoviesUseCase.getPopularMovies();
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

    final result = await topRatedMoviesUseCase.getTopRatedMovies();
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
