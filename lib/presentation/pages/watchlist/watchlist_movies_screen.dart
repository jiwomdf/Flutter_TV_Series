import 'package:flutter/material.dart';
import 'package:flutter_tv_series/common/constants.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/common/utils.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/presentation/pages/search/movie_card_widget.dart';
import 'package:flutter_tv_series/presentation/provider/watchlist_movie_notifier.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesScreen extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesScreenState createState() => _WatchlistMoviesScreenState();
}

class _WatchlistMoviesScreenState extends State<WatchlistMoviesScreen>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies()
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false).fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text('Watch List', style: appTitleLarge),
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistMovieNotifier>(
          builder: (context, data, child) {
            final watchlistState = data.watchlistState;
            switch(watchlistState) {
              case LoadingState():
                return Center(child: CircularProgressIndicator());
              case SuccessState<List<Movie>>():
                if(watchlistState.value.length > 0) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = watchlistState.value[index];
                      return MovieCard(movie);
                    },
                    itemCount: watchlistState.value.length,
                  );
                } else {
                  return Center(child: Text("Watchlist still empty"));
                }
              case ErrorState<List<Movie>>():
                return Center(
                  key: Key('error_message'),
                  child: Text(watchlistState.msg),
                );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
