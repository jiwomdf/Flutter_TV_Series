import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/movie_detail_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late MovieDetailUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = MovieDetailUseCase(mockMovieRepository);
  });

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(1))
        .thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await usecase.getMovieDetail(1);
    // assert
    expect(result, Right(testMovieDetail));
  });
}
