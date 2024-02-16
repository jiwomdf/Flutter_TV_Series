import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchMoviesUseCase {
  final MovieRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> searchMovies(String query) {
    return repository.searchMovies(query);
  }
}
