
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/exception.dart';
import 'package:flutter_tv_series/data/datasource/movie_remote_data_source.dart';
import 'package:flutter_tv_series/data/models/movie_detail_model.dart';
import 'package:flutter_tv_series/data/models/movie_response.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../json_reader.dart';
import '../helpers/test_helper.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main(){
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  test('getNowPlayingMovies should return list of Movie Model when the response code is 200', () async {
    when(mockHttpClient
        .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
        .thenAnswer((_) async =>
        http.Response(readJson('dummy_data/now_playing.json'), 200));

    final result = await dataSource.getNowPlayingMovies();

    expect(result, equals(MovieResponse.fromJson(
        json.decode(readJson('dummy_data/now_playing.json')))
        .movieList));
  });

  test('getNowPlayingMovies should throw a ServerException when the response code is 500', () async {
    when(mockHttpClient
        .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
        .thenAnswer((_) async => http.Response('Not Found', 500));

    final call = dataSource.getNowPlayingMovies();

    expect(() => call, throwsA(isA<ServerException>()));
  });

  test('getPopularMovies should return list of movies when response is success 200', () async {

    when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
        .thenAnswer((_) async =>
        http.Response(readJson('dummy_data/popular.json'), 200));

    final result = await dataSource.getPopularMovies();

    expect(result, MovieResponse.fromJson(
        json.decode(readJson('dummy_data/popular.json')))
        .movieList);
  });

  test('getPopularMovies should throw a ServerException when the response code is 500', () async {

    when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
        .thenAnswer((_) async => http.Response('Not Found', 500));

    final call = dataSource.getPopularMovies();

    expect(() => call, throwsA(isA<ServerException>()));
  });

  test('getTopRatedMovies should return list of movies when response code is 200', () async {

    when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
        .thenAnswer((_) async =>
        http.Response(readJson('dummy_data/top_rated.json'), 200));

    final result = await dataSource.getTopRatedMovies();

    expect(result, MovieResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated.json')))
        .movieList);
  });

  test('getTopRatedMovies should throw ServerException when response code is 500', () async {

    when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
        .thenAnswer((_) async => http.Response('Not Found', 500));

    final call = dataSource.getTopRatedMovies();

    expect(() => call, throwsA(isA<ServerException>()));
  });

  test('getMovieDetail should return movie detail when the response code is 200', () async {
    final id = 1;

    when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY')))
        .thenAnswer((_) async =>
        http.Response(readJson('dummy_data/movie_detail.json'), 200));

    final result = await dataSource.getMovieDetail(id);

    expect(result, equals(MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')))));
  });

  test('getMovieDetail should throw Server Exception when the response code is 500', () async {
    final id = 1;

    when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY')))
        .thenAnswer((_) async => http.Response('Not Found', 500));

    final call = dataSource.getMovieDetail(id);

    expect(() => call, throwsA(isA<ServerException>()));
  });

  test('getMovieRecommendations should return list of Movie Model when the response code is 200', () async {
    final id = 1;

    when(mockHttpClient
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY')))
        .thenAnswer((_) async => http.Response(
        readJson('dummy_data/movie_recommendations.json'), 200));

    final result = await dataSource.getMovieRecommendations(id);

    expect(result, equals(MovieResponse.fromJson(
        json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList));
  });

  test('getMovieRecommendations should throw Server Exception when the response code is 500', () async {
    final id = 1;

    when(mockHttpClient
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY')))
        .thenAnswer((_) async => http.Response('Not Found', 500));

    final call = dataSource.getMovieRecommendations(id);

    expect(() => call, throwsA(isA<ServerException>()));
  });

  test('searchMovies should return list of movies when response code is 200', () async {
    final tQuery = 'Spiderman';

    when(mockHttpClient
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
        .thenAnswer((_) async => http.Response(
        readJson('dummy_data/search_spiderman_movie.json'), 200));

    final result = await dataSource.searchMovies(tQuery);

    expect(result, MovieResponse.fromJson(
        json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList);
  });

  test('searchMovies should throw ServerException when response code is 500', () async {
    final tQuery = 'Spiderman';

    when(mockHttpClient
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
        .thenAnswer((_) async => http.Response('Not Found', 500));

    final call = dataSource.searchMovies(tQuery);

    expect(() => call, throwsA(isA<ServerException>()));
  });

}