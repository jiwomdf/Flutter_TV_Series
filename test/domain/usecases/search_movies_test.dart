import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/search_movies_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late SearchMoviesUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMoviesUseCase(mockMovieRepository);
  });

  final tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.searchMovies(tQuery);
    // assert
    expect(result, Right(testMovieList));
  });
}
