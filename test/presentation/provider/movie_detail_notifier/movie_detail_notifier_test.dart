import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/failure.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/usecases/movie_detail_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/movie_recommendations_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/watchlist_status_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/remove_watchlist_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/save_watchlist_usecase.dart';
import 'package:flutter_tv_series/presentation/provider/movie_detail_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  MovieDetailUseCase,
  MovieRecommendationsUseCase,
  WatchListStatusUseCase,
  SaveWatchlistUseCase,
  RemoveWatchlistUseCase,
])

void main() {
  late MovieDetailNotifier provider;
  late MockMovieDetailUseCase mockMovieDetailUseCase;
  late MockMovieRecommendationsUseCase mockMovieRecommendationsUseCase;
  late MockWatchListStatusUseCase mockWatchListStatusUseCase;
  late MockSaveWatchlistUseCase mockSaveWatchlistUseCase;
  late MockRemoveWatchlistUseCase mockRemoveWatchlistUseCase;

  setUp(() {
    mockMovieDetailUseCase = MockMovieDetailUseCase();
    mockMovieRecommendationsUseCase = MockMovieRecommendationsUseCase();
    mockWatchListStatusUseCase = MockWatchListStatusUseCase();
    mockSaveWatchlistUseCase = MockSaveWatchlistUseCase();
    mockRemoveWatchlistUseCase = MockRemoveWatchlistUseCase();
    provider = MovieDetailNotifier(
      movieDetailUseCase: mockMovieDetailUseCase,
      movieRecommendationsUseCase: mockMovieRecommendationsUseCase,
      watchListStatusUseCase: mockWatchListStatusUseCase,
      saveWatchlistUseCase: mockSaveWatchlistUseCase,
      removeWatchlistUseCase: mockRemoveWatchlistUseCase,
    )..addListener(() {});
  });

  void _arrangeUseCase() {
    when(mockMovieDetailUseCase.getMovieDetail(1))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockMovieRecommendationsUseCase.getMovieRecommendations(1))
        .thenAnswer((_) async => Right(testMovieList));
    when(mockSaveWatchlistUseCase.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    when(mockRemoveWatchlistUseCase.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from Watchlist'));
    when(mockWatchListStatusUseCase.isAddedToWatchlist(1))
        .thenAnswer((_) async => Future.value(true));
  }

  void _arrangeFailedUseCase(){
    when(mockMovieDetailUseCase.getMovieDetail(1))
        .thenAnswer((_) async => Left(ServerFailure('')));
    when(mockMovieRecommendationsUseCase.getMovieRecommendations(1))
        .thenAnswer((_) async => Left(ServerFailure('')));
    when(mockSaveWatchlistUseCase.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => Left(ServerFailure('')));
    when(mockRemoveWatchlistUseCase.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => Left(ServerFailure('')));
    when(mockWatchListStatusUseCase.isAddedToWatchlist(1))
        .thenAnswer((_) async => Future.value(false));
  }


  test('fetchMovieDetail should get data from the usecase', () async {
    _arrangeUseCase();

    await provider.fetchMovieDetail(1);

    verify(mockMovieDetailUseCase.getMovieDetail(1));
    verify(mockMovieRecommendationsUseCase.getMovieRecommendations(1));

    expect((provider.movieState as SuccessState).value, testMovieDetail);
    expect((provider.recommendationState as SuccessState).value, testMovieList);
  });

  test('fetchMovieDetail should failure from the usecase', () async {
    _arrangeFailedUseCase();

    await provider.fetchMovieDetail(1);

    verify(mockMovieDetailUseCase.getMovieDetail(1));
    verify(mockMovieRecommendationsUseCase.getMovieRecommendations(1));

    expect((provider.movieState as ErrorState).msg, '');
  });

  test('fetchMovieDetail should failure recomendation from the usecase', () async {
    when(mockMovieDetailUseCase.getMovieDetail(1))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockMovieRecommendationsUseCase.getMovieRecommendations(1))
        .thenAnswer((_) async => Left(ServerFailure('')));

    await provider.fetchMovieDetail(1);

    verify(mockMovieDetailUseCase.getMovieDetail(1));
    verify(mockMovieRecommendationsUseCase.getMovieRecommendations(1));

    expect((provider.recommendationState as ErrorState).msg, '');
  });

  test('addWatchlist should get data from the usecase', () async {
    _arrangeUseCase();

    await provider.addWatchlist(testMovieDetail);

    verify(mockSaveWatchlistUseCase.saveWatchlist(testMovieDetail));

    expect(provider.watchlistMessage, 'Added to Watchlist');
  });

  test('addWatchlist should failure from the usecase', () async {
    _arrangeFailedUseCase();

    await provider.addWatchlist(testMovieDetail);

    verify(mockSaveWatchlistUseCase.saveWatchlist(testMovieDetail));

    expect(provider.watchlistMessage, '');
  });

  test('addWatchlist should execute remove watchlist when function called', () async {
    _arrangeUseCase();

    await provider.removeFromWatchlist(testMovieDetail);

    verify(mockRemoveWatchlistUseCase.removeWatchlist(testMovieDetail));
    verify(mockWatchListStatusUseCase.isAddedToWatchlist(1));

    expect(provider.watchlistMessage, 'Removed from Watchlist');
  });

  test('addWatchlist should failed remove watchlist when function called', () async {
    _arrangeFailedUseCase();

    await provider.removeFromWatchlist(testMovieDetail);

    verify(mockRemoveWatchlistUseCase.removeWatchlist(testMovieDetail));
    verify(mockWatchListStatusUseCase.isAddedToWatchlist(1));

    expect(provider.watchlistMessage, '');
  });

  test('loadWatchlistStatus should execute remove watchlist when function called', () async {
    _arrangeUseCase();

    await provider.loadWatchlistStatus(1);

    verify(mockWatchListStatusUseCase.isAddedToWatchlist(1));

    expect(provider.isAddedToWatchlist, true);
  });
}
