
import 'package:get_it/get_it.dart';

import '../data/datasource/db/database_helper.dart';
import '../data/datasource/movie_local_data_source.dart';
import '../data/datasource/movie_remote_data_source.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
