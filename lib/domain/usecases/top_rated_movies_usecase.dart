import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class TopRatedMoviesUseCase {
  final MovieRepository repository;

  TopRatedMoviesUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> getTopRatedMovies() {
    return repository.getTopRatedMovies();
  }
}
