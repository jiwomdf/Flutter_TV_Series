import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/watchlist_movies_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late WatchlistMoviesUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = WatchlistMoviesUseCase(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.getWatchlistMovies();
    // assert
    expect(result, Right(testMovieList));
  });
}
