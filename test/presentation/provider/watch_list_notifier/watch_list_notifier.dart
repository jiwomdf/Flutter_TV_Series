import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/usecases/watchlist_movies_usecase.dart';
import 'package:flutter_tv_series/presentation/provider/watchlist_movie_notifier.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'watch_list_notifier.mocks.dart';

@GenerateMocks([
  WatchlistMoviesUseCase
])

void main() {
  late WatchlistMovieNotifier provider;
  late WatchlistMoviesUseCase watchlistMoviesUseCase;

  setUp(() {
    watchlistMoviesUseCase = MockWatchlistMoviesUseCase();
    provider = WatchlistMovieNotifier(
      getWatchlistMoviesUseCase: watchlistMoviesUseCase,
    )..addListener(() {});
  });

  void _arrangeUseCase() {
    when(watchlistMoviesUseCase.getWatchlistMovies())
        .thenAnswer((_) async => Right(testMovieList));
  }

  test('fetchNowPlayingMovies, success', () async {
    _arrangeUseCase();
    await provider.fetchWatchlistMovies();
    verify(watchlistMoviesUseCase.getWatchlistMovies());
    expect((provider.watchlistState as SuccessState).value, testMovieList);
  });

}