import '../repositories/movie_repository.dart';

class GetWatchListStatusUseCase {
  final MovieRepository repository;

  GetWatchListStatusUseCase(this.repository);

  Future<bool> isAddedToWatchlist(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
