import 'package:flutter_tv_series/data/datasource/db/database_helper.dart';
import 'package:flutter_tv_series/data/datasource/movie_local_data_source.dart';
import 'package:flutter_tv_series/data/datasource/movie_remote_data_source.dart';
import 'package:flutter_tv_series/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
