
import 'package:flutter_tv_series/di/provider_injection.dart';

import '../data/repositories/movie_repository_impl.dart';
import '../domain/repositories/movie_repository.dart';

void init() {
  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
}