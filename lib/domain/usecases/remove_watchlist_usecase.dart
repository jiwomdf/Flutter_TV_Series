import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class RemoveWatchlistUseCase {
  final MovieRepository repository;

  RemoveWatchlistUseCase(this.repository);

  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
