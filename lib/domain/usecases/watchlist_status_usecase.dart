import '../repositories/movie_repository.dart';

class WatchListStatusUseCase {
  final MovieRepository repository;

  WatchListStatusUseCase(this.repository);

  Future<bool> isAddedToWatchlist(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
