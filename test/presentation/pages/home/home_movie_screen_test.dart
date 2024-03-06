
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/presentation/pages/home/home_movie_screen.dart';
import 'package:flutter_tv_series/presentation/provider/movie_list_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'home_movie_screen_test.mocks.dart';

@GenerateMocks([
  MovieListNotifier
])
void main() {

  late MockMovieListNotifier mockMovieListNotifier;

  setUp(() => {
    mockMovieListNotifier = MockMovieListNotifier()
  });

  Widget _createScreen(Widget body) =>
      ChangeNotifierProvider<MovieListNotifier>(
        create: (context) => mockMovieListNotifier,
        child: MaterialApp(
            home: body
        ),
      );

  testWidgets('Loading should display CircularProgressIndicator when load the movies', (WidgetTester tester) async {
    provideDummy<SealedState<List<Movie>>>(SealedState.loading());

    when(mockMovieListNotifier.nowPlayingState).thenReturn(SealedState.loading());
    when(mockMovieListNotifier.popularMoviesState).thenReturn(SealedState.loading());
    when(mockMovieListNotifier.topRatedMoviesState).thenReturn(SealedState.loading());

    await tester.pumpWidget(_createScreen(HomeMovieScreen()));
    final titles = find.byType(CircularProgressIndicator);

    expect(titles, findsAny);
  });

  testWidgets('Error should display Text when error load movies', (WidgetTester tester) async {
    provideDummy<SealedState<List<Movie>>>(SealedState.error("error"));

    when(mockMovieListNotifier.nowPlayingState).thenReturn(SealedState.error("error"));
    when(mockMovieListNotifier.popularMoviesState).thenReturn(SealedState.error("error"));
    when(mockMovieListNotifier.topRatedMoviesState).thenReturn(SealedState.error("error"));

    await tester.pumpWidget(_createScreen(HomeMovieScreen()));
    final titles = find.byType(Text);

    expect(titles, findsAny);
  });

  testWidgets('Success should display MovieBannerWidget when success load movies', (WidgetTester tester) async {
    provideDummy<SealedState<List<Movie>>>(SealedState.error("error"));

    when(mockMovieListNotifier.nowPlayingState).thenReturn(SealedState.success(testMovieList));
    when(mockMovieListNotifier.popularMoviesState).thenReturn(SealedState.success(testMovieList));
    when(mockMovieListNotifier.topRatedMoviesState).thenReturn(SealedState.success(testMovieList));

    await tester.pumpWidget(_createScreen(HomeMovieScreen()));
    final titles = find.byType(Text);

    expect(titles, findsAny);
  });

}