import 'dart:io';

import 'package:cosmonaut/core/error/exceptions.dart';
import 'package:cosmonaut/features/article/data/datasources/article_remote_data_source.dart';
import 'package:cosmonaut/features/article/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ArticleRemoteDataSourceImpl remoteDataSource;
  MockHttpClient client;

  setUp(() {
    client = MockHttpClient();
    remoteDataSource = ArticleRemoteDataSourceImpl(client: client);
  });

  void setUpMockHttpClientSuccess200() {
    when(client.get(
      any,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
    )).thenAnswer(
      (_) async => http.Response(
        fixture('article_feed.json'),
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(client.get(
      any,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
    )).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  test(
    'should return a list of articles when the response code is 200',
    () async {
      setUpMockHttpClientSuccess200();

      final result = await remoteDataSource.getArticles(0);

      expect(result, isA<List<ArticleModel>>());
    },
  );

  test('should throw a Server Exception when the response code is not 200', () {
    setUpMockHttpClientFailure404();

    expect(() async => remoteDataSource.getArticles(0),
        throwsA(isA<ServerException>()));
  });

  test(
    'search should return a list of articles when the response code is 200',
    () async {
      setUpMockHttpClientSuccess200();

      final result = await remoteDataSource.searchArticles('test');

      expect(result, isA<List<ArticleModel>>());
    },
  );

  test(
      'search should throw a Server Exception when the response code is not 200',
      () {
    setUpMockHttpClientFailure404();

    expect(() async => remoteDataSource.searchArticles('test'),
        throwsA(isA<ServerException>()));
  });

  test(
    'search should return an empty list when the search term is empty',
    () async {
      setUpMockHttpClientSuccess200();

      final result = await remoteDataSource.searchArticles('');

      expect(result, isA<List<ArticleModel>>());
      expect(result.length, 0);
    },
  );

  test(
    'search should return an empty list when the search term is null',
    () async {
      setUpMockHttpClientSuccess200();

      final result = await remoteDataSource.searchArticles(null);

      expect(result, isA<List<ArticleModel>>());
      expect(result.length, 0);
    },
  );
}
