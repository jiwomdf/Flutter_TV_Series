import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';


class GetNowPlayingMoviesUseCase {
  final MovieRepository repository;

  GetNowPlayingMoviesUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() {
    return repository.getNowPlayingMovies();
  }
}
