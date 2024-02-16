import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;

  MovieSearchNotifier({required this.searchMovies});

  SealedState<List<Movie>> _searchState = SealedState.success([]);
  SealedState<List<Movie>> get searchState => _searchState;

  Future<void> fetchMovieSearch(String query) async {
    _searchState = SealedState.loading();
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _searchState = SealedState.error(failure.message);
        notifyListeners();
      },
      (data) {
        _searchState = SealedState.success(data);
        notifyListeners();
      },
    );
  }
}
