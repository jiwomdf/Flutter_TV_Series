
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_series/common/exception.dart';
import 'package:flutter_tv_series/data/datasource/db/database_helper.dart';
import 'package:flutter_tv_series/data/datasource/movie_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

@GenerateMocks([
  DatabaseHelper
])
void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  test('return success message when insert to database is success', () async {

    when(mockDatabaseHelper.insertWatchlist(testMovieTable))
        .thenAnswer((_) async => 1);

    final result = await dataSource.insertWatchlist(testMovieTable);

    expect(result, 'Added to Watchlist');
  });

  test('throw DatabaseException when insert to database is failed', () async {

    when(mockDatabaseHelper.insertWatchlist(testMovieTable))
        .thenThrow(Exception());

    final call = dataSource.insertWatchlist(testMovieTable);

    expect(() => call, throwsA(isA<DatabaseException>()));
  });


  test('return success message when removeWatchlist to database is success', () async {

    when(mockDatabaseHelper.removeWatchlist(testMovieTable))
        .thenAnswer((_) async => 1);

    final result = await dataSource.removeWatchlist(testMovieTable);

    expect(result, 'Removed from Watchlist');
  });

  test('return DatabaseException when removeWatchlist to database is error', () async {

    when(mockDatabaseHelper.removeWatchlist(testMovieTable))
        .thenThrow(Exception());

    final call = dataSource.removeWatchlist(testMovieTable);

    expect(() => call, throwsA(isA<DatabaseException>()));
  });


  test('return success message when removeWatchlist to database is success', () async {

    when(mockDatabaseHelper.getMovieById(1))
        .thenAnswer((_) async => testMovieMap);

    final result = await dataSource.getMovieById(1);

    expect(result, testMovieTable);
  });

  test('return null message when error getMovieById from database', () async {

    when(mockDatabaseHelper.getMovieById(1))
        .thenAnswer((_) async => null);

    final result = await dataSource.getMovieById(1);

    expect(result, null);
  });

}