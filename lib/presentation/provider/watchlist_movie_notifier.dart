import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_watchlist_movies_usecase.dart';

class WatchlistMovieNotifier extends ChangeNotifier {

  SealedState<List<Movie>> _watchlistState = SealedState.loading();
  SealedState<List<Movie>> get watchlistState => _watchlistState;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  final GetWatchlistMoviesUseCase getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = SealedState.loading();
    notifyListeners();

    final result = await getWatchlistMovies.getWatchlistMovies();
    result.fold(
      (failure) {
        _watchlistState = SealedState.error(failure.message);
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = SealedState.success(moviesData);
        notifyListeners();
      },
    );
  }
}
