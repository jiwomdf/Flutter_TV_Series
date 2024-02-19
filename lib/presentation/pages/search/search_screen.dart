import 'package:flutter/material.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:provider/provider.dart';
import '../../../common/constants.dart';
import '../../provider/movie_search_notifier.dart';
import 'movie_card_widget.dart';

class SearchScreen extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text('Search Result', style: titleLarge),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                final searchState = data.searchState;
                return switch (searchState) {
                  LoadingState<List<Movie>>() => Center(child: CircularProgressIndicator()),
                  ErrorState<List<Movie>>() => Expanded(child: Container()),
                  SuccessState<List<Movie>>() => Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = searchState.value[index];
                        return MovieCard(movie);
                      },
                    itemCount: searchState.value.length,
                  )
                ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
