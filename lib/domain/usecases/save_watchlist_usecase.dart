import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class SaveWatchlistUseCase {
  final MovieRepository repository;

  SaveWatchlistUseCase(this.repository);

  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
