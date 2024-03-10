import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/now_playing_movies_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late NowPlayingMoviesUseCase useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = NowPlayingMoviesUseCase(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    when(mockMovieRepository.getNowPlayingMovies())
        .thenAnswer((_) async => Right(testMovieList));
    final result = await useCase.getNowPlayingMovies();
    expect(result, Right(testMovieList));
  });
}
