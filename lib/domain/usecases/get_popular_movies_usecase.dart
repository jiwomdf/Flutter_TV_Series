import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetPopularMoviesUseCase {
  final MovieRepository repository;

  GetPopularMoviesUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> getPopularMovies() {
    return repository.getPopularMovies();
  }
}
