import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/remove_watchlist_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../data/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late RemoveWatchlistUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlistUseCase(mockMovieRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.removeWatchlist(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
