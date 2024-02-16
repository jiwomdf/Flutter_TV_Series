import 'package:flutter/material.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/domain/entities/movie_detail.dart';
import 'package:provider/provider.dart';
import '../../provider/movie_detail_notifier.dart';
import 'detail_content_widget.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          final movie = provider.movieState;
          final recommendations = provider.recommendationState;
          return switch(movie) {
            LoadingState() => Center(child: CircularProgressIndicator()),
            SuccessState<MovieDetail>() =>
              switch(recommendations) {
                LoadingState() => CircularProgressIndicator(),
                ErrorState<List<Movie>>() => Text(recommendations.msg),
                SuccessState<List<Movie>>() => SafeArea(
                    child: DetailContent(
                        movie.value,
                        recommendations.value,
                        provider.isAddedToWatchlist
                    )
                )
              },
            ErrorState<MovieDetail>() => Text(movie.msg)
          };
        },
      ),
    );
  }
}
