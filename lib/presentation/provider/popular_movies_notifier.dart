import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  PopularMoviesNotifier(this.getPopularMovies);

  SealedState<List<Movie>> _state = SealedState<List<Movie>>.loading();
    get state => _state;

  Future<void> fetchPopularMovies() async {
    _state = SealedState.loading();
    notifyListeners();

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        _state = SealedState.error(failure.message);
        notifyListeners();
      },
      (moviesData) {
        _state = SealedState.success(moviesData);
        notifyListeners();
      },
    );
  }
}