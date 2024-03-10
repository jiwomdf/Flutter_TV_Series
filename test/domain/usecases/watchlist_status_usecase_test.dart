import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/watchlist_status_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../data/helpers/test_helper.mocks.dart';

void main() {
  late WatchListStatusUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = WatchListStatusUseCase(mockMovieRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.isAddedToWatchlist(1);
    // assert
    expect(result, true);
  });
}
