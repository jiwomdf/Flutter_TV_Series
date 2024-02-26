import 'package:flutter/material.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:provider/provider.dart';
import '../../provider/movie_search_notifier.dart';
import 'widget/movie_card_widget.dart';

class SearchScreen extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 55,
                child: TextField(
                  onSubmitted: (query) {
                    Provider.of<MovieSearchNotifier>(context, listen: false)
                        .fetchMovieSearch(query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search)
                  ),
                  textInputAction: TextInputAction.search,
                ),
              ),
              SizedBox(height: 16),
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
      ),
    );
  }
}
