
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
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

  void _arrangeUseCase() {
    when(searchMoviesUseCase.searchMovies("test"))
        .thenAnswer((_) async => Right(testMovieList));
  }

  test('fetchNowPlayingMovies, success', () async {
    _arrangeUseCase();
    await provider.fetchMovieSearch("test");
    verify(searchMoviesUseCase.searchMovies("test"));
    expect((provider.searchState as SuccessState).value, testMovieList);
  });

}