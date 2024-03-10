
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/failure.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/domain/usecases/search_movies_usecase.dart';
import 'package:flutter_tv_series/presentation/provider/movie_search_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_search_notifier.mocks.dart';

@GenerateMocks([
  SearchMoviesUseCase
])

void main() {
  late MovieSearchNotifier provider;
  late SearchMoviesUseCase searchMoviesUseCase;

  setUp(() {
    searchMoviesUseCase = MockSearchMoviesUseCase();
    provider = MovieSearchNotifier(
        searchMoviesUseCase: searchMoviesUseCase,
    )..addListener(() {});
  });

  test('fetchNowPlayingMovies, loading', () async {
    when(searchMoviesUseCase.searchMovies("test"))
        .thenAnswer((_) async => Right(testMovieList));
    provider.fetchMovieSearch("test");
    verify(searchMoviesUseCase.searchMovies("test"));
    expect((provider.searchState).toString(), LoadingState<List<Movie>>().toString());
  });

  test('fetchNowPlayingMovies, success', () async {
    when(searchMoviesUseCase.searchMovies("test"))
        .thenAnswer((_) async => Right(testMovieList));
    await provider.fetchMovieSearch("test");
    verify(searchMoviesUseCase.searchMovies("test"));
    expect((provider.searchState as SuccessState).value, testMovieList);
  });

  test('fetchNowPlayingMovies, error', () async {
    when(searchMoviesUseCase.searchMovies("test"))
        .thenAnswer((_) async => Left(ServerFailure('')));
    await provider.fetchMovieSearch("test");
    verify(searchMoviesUseCase.searchMovies("test"));
    expect((provider.searchState as ErrorState).msg, '');
  });

}