import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/movie_recommendations_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late MovieRecommendationsUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = MovieRecommendationsUseCase(mockMovieRepository);
  });

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getMovieRecommendations(1))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.getMovieRecommendations(1);
    // assert
    expect(result, Right(testMovieList));
  });
}
