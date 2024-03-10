import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/presentation/pages/watchlist/watchlist_movies_screen.dart';
import 'package:flutter_tv_series/presentation/provider/watchlist_movie_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_screen_test.mocks.dart';

@GenerateMocks([
  WatchlistMovieNotifier
])
void main() {

    late MockWatchlistMovieNotifier mockWatchlistMovieNotifier;

    setUp(() => {
        mockWatchlistMovieNotifier = MockWatchlistMovieNotifier()
    });

    Widget _createScreen(Widget body) =>
        ChangeNotifierProvider<WatchlistMovieNotifier>(
        create: (context) => mockWatchlistMovieNotifier,
        child: MaterialApp(
            home: body
        ),
    );

    testWidgets('Loading should display CircularProgressIndicator when load the movies', (tester) async {
        provideDummy<SealedState<List<Movie>>>(SealedState.loading());

        when(mockWatchlistMovieNotifier.watchlistState).thenReturn(SealedState.loading());

        await tester.pumpWidget(_createScreen(WatchlistMoviesScreen()));
        final titles = find.byType(CircularProgressIndicator);

        expect(titles, findsAny);
    });

    testWidgets('Error should display Text when load the movies', (tester) async {
        provideDummy<SealedState<List<Movie>>>(SealedState.error('error'));

        when(mockWatchlistMovieNotifier.watchlistState).thenReturn(SealedState.error('error'));

        await tester.pumpWidget(_createScreen(WatchlistMoviesScreen()));
        final titles = find.byType(Text);

        expect(titles, findsAny);
    });

    testWidgets('Success should display ListView when load the movies', (tester) async {
        provideDummy<SealedState<List<Movie>>>(SealedState.success(testMovieList));

        when(mockWatchlistMovieNotifier.watchlistState).thenReturn(SealedState.success(testMovieList));

        await tester.pumpWidget(_createScreen(WatchlistMoviesScreen()));
        final titles = find.byType(ListView);

        expect(titles, findsAny);
    });
}