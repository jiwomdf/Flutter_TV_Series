import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/get_popular_movies_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:flutter_tv_series/presentation/provider/movie_list_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_list_notifier.mocks.dart';

@GenerateMocks([
  GetNowPlayingMoviesUseCase,
  GetPopularMoviesUseCase,
  GetTopRatedMoviesUseCase,
])
void main() {

  late MovieListProvider provider;
  late GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  late GetPopularMoviesUseCase getPopularMoviesUseCase;
  late GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  setUp(() {
    getNowPlayingMoviesUseCase = MockGetNowPlayingMoviesUseCase();
    getPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    getTopRatedMoviesUseCase = MockGetTopRatedMoviesUseCase();
    provider = MovieListProvider(
        getNowPlayingMoviesUseCase: getNowPlayingMoviesUseCase,
        getPopularMoviesUseCase: getPopularMoviesUseCase,
        getTopRatedMoviesUseCase: getTopRatedMoviesUseCase)
      ..addListener(() {});
  });

  void _arrangeUseCase() {
    when(getNowPlayingMoviesUseCase.getNowPlayingMovies())
        .thenAnswer((_) async => Right(testMovieList));
    when(getPopularMoviesUseCase.getPopularMovies())
        .thenAnswer((_) async => Right(testMovieList));
    when(getTopRatedMoviesUseCase.getTopRatedMovies())
        .thenAnswer((_) async => Right(testMovieList));
  }

  test('fetchNowPlayingMovies, success', () async {
    _arrangeUseCase();
    await provider.fetchNowPlayingMovies();
    verify(getNowPlayingMoviesUseCase.getNowPlayingMovies());
    expect((provider.nowPlayingState as SuccessState).value, testMovieList);
  });

  test('fetchPopularMovies, success', () async {
    _arrangeUseCase();
    await provider.fetchPopularMovies();
    verify(getPopularMoviesUseCase.getPopularMovies());
    expect((provider.popularMoviesState as SuccessState).value, testMovieList);
  });

  test('fetchTopRatedMovies, success', () async {
    _arrangeUseCase();
    await provider.fetchTopRatedMovies();
    verify(getTopRatedMoviesUseCase.getTopRatedMovies());
    expect((provider.topRatedMoviesState as SuccessState).value, testMovieList);
  });
}
