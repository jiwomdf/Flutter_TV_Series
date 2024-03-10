import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/top_rated_movies_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late TopRatedMoviesUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = TopRatedMoviesUseCase(mockMovieRepository);
  });


  test('should get list of movies from repository', () async {
    // arrange
    when(mockMovieRepository.getTopRatedMovies())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.getTopRatedMovies();
    // assert
    expect(result, Right(testMovieList));
  });
}
