import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/save_watchlist_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late SaveWatchlistUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlistUseCase(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.saveWatchlist(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
