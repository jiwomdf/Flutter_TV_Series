import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/popular_movies_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late PopularMoviesUseCase usecase;
  late MockMovieRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    usecase = PopularMoviesUseCase(mockMovieRpository);
  });

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test('should get list of movies from the repository when execute function is called', () async {
        // arrange
        when(mockMovieRpository.getPopularMovies())
            .thenAnswer((_) async => Right(testMovieList));
        // act
        final result = await usecase.getPopularMovies();
        // assert
        expect(result, Right(testMovieList));
      });
    });
  });
}
