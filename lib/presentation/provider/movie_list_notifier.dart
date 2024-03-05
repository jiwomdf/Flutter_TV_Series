import 'package:flutter/material.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies_usecase.dart';
import '../../domain/usecases/get_popular_movies_usecase.dart';
import '../../domain/usecases/get_top_rated_movies_usecase.dart';

class MovieListNotifier extends ChangeNotifier {

  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MovieListNotifier({
    required this.getNowPlayingMoviesUseCase,
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
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

    final result = await getNowPlayingMoviesUseCase.getNowPlayingMovies();
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

    final result = await getPopularMoviesUseCase.getPopularMovies();
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

    final result = await getTopRatedMoviesUseCase.getTopRatedMovies();
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
