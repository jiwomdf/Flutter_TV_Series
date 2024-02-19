import 'package:flutter/material.dart';
import 'package:flutter_tv_series/common/state_enum.dart';
import 'package:flutter_tv_series/presentation/pages/home/widgets/movie_banner_widget.dart';
import 'package:flutter_tv_series/presentation/pages/search/search_screen.dart';
import 'package:flutter_tv_series/presentation/pages/watchlist/watchlist_movies_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/constants.dart';
import '../../../domain/entities/movie.dart';
import '../../provider/movie_list_notifier.dart';
import 'widgets/movie_list_widget.dart';

class HomeMovieScreen extends StatefulWidget {
  @override
  _HomeMovieScreenState createState() => _HomeMovieScreenState();
}

class _HomeMovieScreenState extends State<HomeMovieScreen> {
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
      drawer: drawer(),
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Now Playing', style: titleLarge),
              Consumer<MovieListProvider>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                return switch (state) {
                  LoadingState() => Center(child: CircularProgressIndicator()),
                  SuccessState<List<Movie>>() => MovieBannerWidget(movies: state.value),
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
          style: titleLarge,
        ),
      ],
    );
  }

  Widget drawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.webp'),
            ),
            accountName: Text('Amabelle'),
            accountEmail: Text('Amabelle@gmail.com'),
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
              Navigator.pushNamed(context, WatchlistMoviesScreen.ROUTE_NAME);
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
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.grey[200],
      title: Text('TV Series', style: appTitleLarge),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchScreen.ROUTE_NAME);
          },
          icon: Icon(Icons.search, color: Colors.deepPurple),
        )
      ],
      iconTheme: IconThemeData(color: Colors.deepPurple),
    );
  }
}
