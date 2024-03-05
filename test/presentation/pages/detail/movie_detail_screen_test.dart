
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/domain/entities/movie_detail.dart';
import 'package:flutter_tv_series/presentation/pages/detail/movie_detail_screen.dart';
import 'package:flutter_tv_series/presentation/pages/detail/widget/detail_content_widget.dart';
import 'package:flutter_tv_series/presentation/provider/movie_detail_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_screen_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main(){
  late MockMovieDetailNotifier mockMovieDetailNotifier;

  setUp(() => {
    mockMovieDetailNotifier = MockMovieDetailNotifier()
  });

  Widget _createScreen(Widget body) =>
      ChangeNotifierProvider<MovieDetailNotifier>(
        create: (context) => mockMovieDetailNotifier,
        child: MaterialApp(
            home: body
        ),
      );

  testWidgets('Loading should display when loading movie detail', (WidgetTester tester) async {
    provideDummy<SealedState<MovieDetail>>(SealedState.loading());
    provideDummy<SealedState<List<Movie>>>(SealedState.loading());

    when(mockMovieDetailNotifier.movieState).thenReturn(SealedState.loading());
    when(mockMovieDetailNotifier.recommendationState).thenReturn(SealedState.loading());

    await tester.pumpWidget(_createScreen(MovieDetailScreen(id: 1)));
    final titles = find.byType(CircularProgressIndicator);

    expect(titles, findsOne);
  });

  testWidgets('Text should display when error loading movie detail', (WidgetTester tester) async {
    provideDummy<SealedState<MovieDetail>>(SealedState.error("error"));
    provideDummy<SealedState<List<Movie>>>(SealedState.error("error"));

    when(mockMovieDetailNotifier.movieState).thenReturn(SealedState.error("error"));
    when(mockMovieDetailNotifier.recommendationState).thenReturn(SealedState.error("error"));

    await tester.pumpWidget(_createScreen(MovieDetailScreen(id: 1)));
    final titles = find.byType(Text);

    expect(titles, findsOne);
  });

  testWidgets('DetailContent should display when success load movie detail', (WidgetTester tester) async {
    provideDummy<SealedState<MovieDetail>>(SealedState.success(testMovieDetail));
    provideDummy<SealedState<List<Movie>>>(SealedState.success(testMovieList));

    when(mockMovieDetailNotifier.movieState).thenReturn(SealedState.success(testMovieDetail));
    when(mockMovieDetailNotifier.recommendationState).thenReturn(SealedState.success(testMovieList));
    when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(true);

    await tester.pumpWidget(_createScreen(MovieDetailScreen(id: 1)));
    final titles = find.byType(DetailContent);

    expect(titles, findsOne);
  });

}