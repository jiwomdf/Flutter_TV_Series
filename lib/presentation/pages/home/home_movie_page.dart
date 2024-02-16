import 'package:flutter/material.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:provider/provider.dart';
import '../../../common/constants.dart';
import '../../../domain/entities/movie.dart';
import '../../provider/movie_list_notifier.dart';
import 'movie_list_widget.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListProvider>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('TV Series'),
              accountEmail: Text('tvseries@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                //Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                //Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              //Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Now Playing', style: kHeading6),
              Consumer<MovieListProvider>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                return switch (state) {
                  LoadingState() => Center(child: CircularProgressIndicator()),
                  SuccessState<List<Movie>>() => MovieList(state.value),
                  ErrorState<List<Movie>>() => Text(state.msg)
                };
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: (){}//() => Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListProvider>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                return switch (state) {
                  LoadingState() => Center(child: CircularProgressIndicator()),
                  SuccessState<List<Movie>>() => MovieList(state.value),
                  ErrorState<List<Movie>>() => Text(state.msg)
                };
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: (){} //() => Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListProvider>(builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                return switch (state) {
                  LoadingState() => Center(child: CircularProgressIndicator()),
                  SuccessState<List<Movie>>() => MovieList(state.value),
                  ErrorState<List<Movie>>() => Text(state.msg)
                };
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
