import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_detail_usecase.dart';
import '../../domain/usecases/get_movie_recommendations_usecase.dart';
import '../../domain/usecases/get_watchlist_status_usecase.dart';
import '../../domain/usecases/remove_watchlist_usecase.dart';
import '../../domain/usecases/save_watchlist_usecase.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetailUseCase getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusUseCase getWatchListStatus;
  final SaveWatchlistUseCase saveWatchlist;
  final RemoveWatchlistUseCase removeWatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  SealedState<MovieDetail> _movieState = SealedState.loading();
  SealedState<MovieDetail> get movieState => _movieState;

  SealedState<List<Movie>> _recommendationState = SealedState.loading();
  SealedState<List<Movie>> get recommendationState => _recommendationState;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = SealedState.loading();
    notifyListeners();
    final detailResult = await getMovieDetail.getMovieDetail(id);
    final recommendationResult = await getMovieRecommendations.getMovieRecommendations(id);
    detailResult.fold(
      (failure) {
        _movieState = SealedState.error(failure.message);
        notifyListeners();
      },
      (movie) {
        _recommendationState = SealedState.loading();
        _movieState = SealedState.success(movie);
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = SealedState.error(failure.message);
          },
          (movies) {
            _recommendationState = SealedState.success(movies);
          },
        );
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.saveWatchlist(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.removeWatchlist(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.isAddedToWatchlist(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
