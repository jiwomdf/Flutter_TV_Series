import 'package:flutter/foundation.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesNotifier({required this.getTopRatedMovies});

  SealedState<List<Movie>> _state = SealedState.loading();
    get state => _state;

  Future<void> fetchTopRatedMovies() async {
    _state = SealedState.loading();
    notifyListeners();

    final result = await getTopRatedMovies.execute();

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
