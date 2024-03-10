import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';


class NowPlayingMoviesUseCase {
  final MovieRepository repository;

  NowPlayingMoviesUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() {
    return repository.getNowPlayingMovies();
  }
}
