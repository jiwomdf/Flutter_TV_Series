import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../../domain/entities/genre.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../provider/movie_detail_notifier.dart';
import 'movie_detail_screen.dart';

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  height: 350,
                  width: screenWidth,
                  fit: BoxFit.cover,
                  imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    foregroundColor: Colors.deepPurple,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  color: isDarkMode ? Colors.black : Colors.white
              ),
              padding: const EdgeInsets.only(left: 16 , right: 16),
              child: dataDetail(context),
            )
          ],
        ),
      ),
    );
  }

  Widget dataDetail(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(movie.title, style: headlineSmall)),
                    ElevatedButton(
                      onPressed: () async {
                        final notifier = Provider.of<MovieDetailNotifier>(context, listen: false);
                        if (!isAddedWatchlist) {
                          await notifier.addWatchlist(movie);
                        } else {
                          await notifier.removeFromWatchlist(movie);
                        }

                        final message = notifier.watchlistMessage;
                        if (message == MovieDetailNotifier.watchlistAddSuccessMessage ||
                            message == MovieDetailNotifier.watchlistRemoveSuccessMessage) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)));
                        } else {
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(content: Text(message));
                          });
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
                          Text('Watchlist'),
                        ],
                      ),
                    ),
                  ]
              ),
              Text(_showGenres(movie.genres)),
              Text(_showDuration(movie.runtime)),
              ratingBar(),
              SizedBox(height: 16),
              Text(
                'Overview',
                style: titleLarge,
              ),
              Text(
                movie.overview,
              ),
              SizedBox(height: 16),
              Text(
                'Recommendations',
                style: titleLarge,
              ),
              Consumer<MovieDetailNotifier>(
                  builder: (context, data, child) {
                    var recommendationState =
                        data.recommendationState;
                    return switch (recommendationState) {
                      LoadingState() => Center(child: CircularProgressIndicator()),
                      ErrorState<List<Movie>>() => Text(recommendationState.msg),
                      SuccessState<List<Movie>>() => Container(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final movie = recommendations[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    MovieDetailScreen.ROUTE_NAME,
                                    arguments: movie.id,
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                    placeholder: (context, url) =>
                                        Center(
                                          child:
                                          CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: recommendations.length,
                        ),
                      )
                    };
                  }),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            color: Colors.white,
            height: 4,
            width: 48,
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget ratingBar() {
    return Row(
      children: [
        RatingBarIndicator(
          rating: movie.voteAverage / 2,
          itemCount: 5,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: kMikadoYellow,
          ),
          itemSize: 24,
        ),
        Text('${movie.voteAverage}')
      ],
    );
  }

}
