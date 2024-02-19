import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv_series/common/constants.dart';
import 'package:flutter_tv_series/domain/entities/movie.dart';
import 'package:flutter_tv_series/presentation/pages/detail/movie_detail_screen.dart';

class MovieBannerWidget extends StatelessWidget {
  final List<Movie> movies;

  const MovieBannerWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            width: 250,
            child: Stack(
              fit: StackFit.expand,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MovieDetailScreen.ROUTE_NAME, arguments: movie.id);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CachedNetworkImage(
                          imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, right: 8),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                        movie.title ?? "",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
