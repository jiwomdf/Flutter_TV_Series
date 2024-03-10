import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/popular_movies_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late PopularMoviesUseCase useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = PopularMoviesUseCase(mockMovieRepository);
  });

  test('should get list of movies from the repository when execute function is called', () async {
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => Right(testMovieList));
    final result = await useCase.getPopularMovies();
    expect(result, Right(testMovieList));
  });
}
