import 'package:equatable/equatable.dart';
import 'movie_model.dart';

class MovieResponse {
  final List<MovieModel> movieList;

  MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        movieList: List<MovieModel>.from((json["results"] as List)
            .map((x) => MovieModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );
}
