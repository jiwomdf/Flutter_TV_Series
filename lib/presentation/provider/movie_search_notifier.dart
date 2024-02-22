import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies_usecase.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMoviesUseCase searchMoviesUseCase;

  MovieSearchNotifier({required this.searchMoviesUseCase});

  SealedState<List<Movie>> _searchState = SealedState.success([]);
  SealedState<List<Movie>> get searchState => _searchState;

  Future<void> fetchMovieSearch(String query) async {
    _searchState = SealedState.loading();
    notifyListeners();

    final result = await searchMoviesUseCase.searchMovies(query);
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
