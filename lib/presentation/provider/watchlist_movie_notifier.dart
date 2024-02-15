import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_watchlist_movies.dart';

class WatchlistMovieNotifier extends ChangeNotifier {

  SealedState<List<Movie>> _watchlistState = SealedState.loading();
    get watchlistState => _watchlistState;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = SealedState.loading();
    notifyListeners();

    final result = await getWatchlistMovies.execute();
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
