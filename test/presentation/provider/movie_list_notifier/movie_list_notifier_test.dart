import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/failure.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/usecases/now_playing_movies_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/popular_movies_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/top_rated_movies_usecase.dart';
import 'package:flutter_tv_series/presentation/provider/movie_list_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([
  NowPlayingMoviesUseCase,
  PopularMoviesUseCase,
  TopRatedMoviesUseCase,
])
void main() {

  late MovieListNotifier provider;
  late MockNowPlayingMoviesUseCase mockNowPlayingMoviesUseCase;
  late MockPopularMoviesUseCase mockPopularMoviesUseCase;
  late MockTopRatedMoviesUseCase mockTopRatedMoviesUseCase;

  setUp(() {
    mockNowPlayingMoviesUseCase = MockNowPlayingMoviesUseCase();
    mockPopularMoviesUseCase = MockPopularMoviesUseCase();
    mockTopRatedMoviesUseCase = MockTopRatedMoviesUseCase();
    provider = MovieListNotifier(
        nowPlayingMoviesUseCase: mockNowPlayingMoviesUseCase,
        popularMoviesUseCase: mockPopularMoviesUseCase,
        topRatedMoviesUseCase: mockTopRatedMoviesUseCase
    )..addListener(() {});
  });

  void _arrangeUseCase() {
    when(mockNowPlayingMoviesUseCase.getNowPlayingMovies())
        .thenAnswer((_) async => Right(testMovieList));
    when(mockPopularMoviesUseCase.getPopularMovies())
        .thenAnswer((_) async => Right(testMovieList));
    when(mockTopRatedMoviesUseCase.getTopRatedMovies())
        .thenAnswer((_) async => Right(testMovieList));
  }

  void _arrangeFailedUseCase() {
    when(mockNowPlayingMoviesUseCase.getNowPlayingMovies())
        .thenAnswer((_) async => Left(ServerFailure('')));
    when(mockPopularMoviesUseCase.getPopularMovies())
        .thenAnswer((_) async => Left(ServerFailure('')));
    when(mockTopRatedMoviesUseCase.getTopRatedMovies())
        .thenAnswer((_) async => Left(ServerFailure('')));
  }

  test('fetchNowPlayingMovies should get data from the usecase', () async {
    _arrangeUseCase();

    await provider.fetchNowPlayingMovies();

    verify(mockNowPlayingMoviesUseCase.getNowPlayingMovies());

    expect((provider.nowPlayingState as SuccessState).value, testMovieList);
  });

  test('fetchNowPlayingMovies error get data from the usecase', () async {
    _arrangeFailedUseCase();

    await provider.fetchNowPlayingMovies();

    verify(mockNowPlayingMoviesUseCase.getNowPlayingMovies());

    expect((provider.nowPlayingState as ErrorState).msg, '');
  });

  test('fetchPopularMovies should get data from the usecase', () async {
    _arrangeUseCase();

    await provider.fetchPopularMovies();

    verify(mockPopularMoviesUseCase.getPopularMovies());

    expect((provider.popularMoviesState as SuccessState).value, testMovieList);
  });

  test('fetchPopularMovies error get data from the usecase', () async {
    _arrangeFailedUseCase();

    await provider.fetchPopularMovies();

    verify(mockPopularMoviesUseCase.getPopularMovies());

    expect((provider.popularMoviesState as ErrorState).msg, '');
  });

  test('fetchTopRatedMovies should get data from the usecase', () async {
    _arrangeUseCase();

    await provider.fetchTopRatedMovies();

    verify(mockTopRatedMoviesUseCase.getTopRatedMovies());

    expect((provider.topRatedMoviesState as SuccessState).value, testMovieList);
  });

  test('fetchTopRatedMovies error get data from the usecase', () async {
    _arrangeFailedUseCase();

    await provider.fetchTopRatedMovies();

    verify(mockTopRatedMoviesUseCase.getTopRatedMovies());

    expect((provider.topRatedMoviesState as ErrorState).msg, '');
  });
}
