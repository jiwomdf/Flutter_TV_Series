import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/domain/usecases/watchlist_status_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../data/helpers/test_helper.mocks.dart';

void main() {
  late WatchListStatusUseCase useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = WatchListStatusUseCase(mockMovieRepository);
  });

  test('should get watchlist status from repository', () async {
    when(mockMovieRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    final result = await useCase.isAddedToWatchlist(1);
    expect(result, true);
  });
}
