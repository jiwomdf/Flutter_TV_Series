import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class MovieRecommendationsUseCase {
  final MovieRepository repository;

  MovieRecommendationsUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> getMovieRecommendations(id) {
    return repository.getMovieRecommendations(id);
  }
}
