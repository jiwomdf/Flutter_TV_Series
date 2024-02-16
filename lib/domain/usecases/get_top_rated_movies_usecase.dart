import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopRatedMoviesUseCase {
  final MovieRepository repository;

  GetTopRatedMoviesUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> getTopRatedMovies() {
    return repository.getTopRatedMovies();
  }
}
