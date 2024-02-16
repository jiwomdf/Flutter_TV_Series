import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetWatchlistMoviesUseCase {
  final MovieRepository _repository;

  GetWatchlistMoviesUseCase(this._repository);

  Future<Either<Failure, List<Movie>>> getWatchlistMovies() {
    return _repository.getWatchlistMovies();
  }
}
