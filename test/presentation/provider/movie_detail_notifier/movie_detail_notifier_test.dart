import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/failure.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/domain/usecases/get_movie_detail_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/get_movie_recommendations_usecase.dart';
import 'package:flutter_tv_series/domain/usecases/get_watchlist_status_usecase.dart';
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
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
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
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  void _arrangeUseCase() {
    when(mockMovieDetailUseCase.getMovieDetail(tMovie.id))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockMovieRecommendationsUseCase.getMovieRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      verify(mockMovieDetailUseCase.getMovieDetail(tId));
      verify(mockMovieRecommendationsUseCase.getMovieRecommendations(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUseCase();
      // act
      provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, SealedState.loading());
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, SealedState.success(testMovieDetail));
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, SealedState.success(tMovies));
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      verify(mockMovieRecommendationsUseCase.getMovieRecommendations(tId));
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect((provider.recommendationState as SuccessState).value, tMovies);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockMovieDetailUseCase.getMovieDetail(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockMovieRecommendationsUseCase.getMovieRecommendations(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.recommendationState, SealedState.error('Failed'));
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockWatchListStatusUseCase.isAddedToWatchlist(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistUseCase.saveWatchlist(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockWatchListStatusUseCase.isAddedToWatchlist(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testMovieDetail);
      // assert
      verify(mockSaveWatchlistUseCase.saveWatchlist(testMovieDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistUseCase.removeWatchlist(testMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockWatchListStatusUseCase.isAddedToWatchlist(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testMovieDetail);
      // assert
      verify(mockRemoveWatchlistUseCase.removeWatchlist(testMovieDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistUseCase.saveWatchlist(testMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockWatchListStatusUseCase.isAddedToWatchlist(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testMovieDetail);
      // assert
      verify(mockWatchListStatusUseCase.isAddedToWatchlist(testMovieDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistUseCase.saveWatchlist(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockWatchListStatusUseCase.isAddedToWatchlist(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testMovieDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockMovieDetailUseCase.getMovieDetail(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockMovieRecommendationsUseCase.getMovieRecommendations(tId))
          .thenAnswer((_) async => Right(tMovies));
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, SealedState.error('Server Failure'));
      expect(listenerCallCount, 2);
    });
  });
}
