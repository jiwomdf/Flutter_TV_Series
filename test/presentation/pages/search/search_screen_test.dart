import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/presentation/pages/search/search_screen.dart';
import 'package:flutter_tv_series/presentation/provider/movie_search_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_screen_test.mocks.dart';

@GenerateMocks([
  MovieSearchNotifier
])
void main() {

  late MockMovieSearchNotifier mockMovieSearchNotifier;

  setUp(() => {
    mockMovieSearchNotifier = MockMovieSearchNotifier()
  });

  Widget _createScreen(Widget body) =>
      ChangeNotifierProvider<MovieSearchNotifier>(
        create: (context) => mockMovieSearchNotifier,
        child: MaterialApp(
            home: body
        ),
      );

  testWidgets('Loading should display CircularProgressIndicator when load the movies', (tester) async {
    provideDummy<SealedState<List<Movie>>>(SealedState.loading());

    when(mockMovieSearchNotifier.searchState).thenReturn(SealedState.loading());

    await tester.pumpWidget(_createScreen(SearchScreen()));
    final titles = find.byType(CircularProgressIndicator);

    expect(titles, findsAny);
  });

  testWidgets('Error should display Text when load the movies', (tester) async {
      provideDummy<SealedState<List<Movie>>>(SealedState.error('error'));

      when(mockMovieSearchNotifier.searchState).thenReturn(SealedState.error('error'));

      await tester.pumpWidget(_createScreen(SearchScreen()));
      final titles = find.byType(Text);

      expect(titles, findsAny);
    });

  testWidgets('Success should display ListView when load the movies', (tester) async {
      provideDummy<SealedState<List<Movie>>>(SealedState.success(testMovieList));

      when(mockMovieSearchNotifier.searchState).thenReturn(SealedState.success(testMovieList));

      await tester.pumpWidget(_createScreen(SearchScreen()));
      final titles = find.byType(ListView);

      expect(titles, findsAny);
    });
}