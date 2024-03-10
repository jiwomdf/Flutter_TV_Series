import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/top_rated_movies_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late TopRatedMoviesUseCase useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = TopRatedMoviesUseCase(mockMovieRepository);
  });


  test('should get list of movies from repository', () async {
    when(mockMovieRepository.getTopRatedMovies())
        .thenAnswer((_) async => Right(testMovieList));
    final result = await useCase.getTopRatedMovies();
    expect(result, Right(testMovieList));
  });
}
