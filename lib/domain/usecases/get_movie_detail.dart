import 'package:dartz/dartz.dart';
import 'package:flutter_tv_series/common/failure.dart';
import 'package:flutter_tv_series/domain/entities/movie_detail.dart';
import 'package:flutter_tv_series/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
