import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;

  MovieSearchNotifier({required this.searchMovies});

  SealedState<List<Movie>> _state = SealedState.loading();
    get state => _state;

  List<Movie> _searchResult = [];
    get searchResult => _searchResult;

  Future<void> fetchMovieSearch(String query) async {
    _state = SealedState.loading();
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _state = SealedState.error(failure.message);
        notifyListeners();
      },
      (data) {
        _state = SealedState.success(data);
        notifyListeners();
      },
    );
  }
}
