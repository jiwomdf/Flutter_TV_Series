import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/search_movies_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late SearchMoviesUseCase useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = SearchMoviesUseCase(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    final tQuery = 'Spiderman';
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(testMovieList));
    final result = await useCase.searchMovies(tQuery);
    expect(result, Right(testMovieList));
  });
}
