import 'package:cosmonaut/core/error/exceptions.dart';
import 'package:cosmonaut/core/error/failures.dart';
import 'package:cosmonaut/core/network/network_info.dart';
import 'package:cosmonaut/features/article/data/datasources/article_local_data_source.dart';
import 'package:cosmonaut/features/article/data/datasources/article_remote_data_source.dart';
import 'package:cosmonaut/features/article/data/models/article_model.dart';
import 'package:cosmonaut/features/article/data/repositories/article_repository_impl.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockArticleLocalDataSource extends Mock
    implements ArticleLocalDataSource {}

class MockArticleRemoteDataSource extends Mock
    implements ArticleRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockArticleLocalDataSource localDataSource;
  MockArticleRemoteDataSource remoteDataSource;
  MockNetworkInfo networkInfo;

  ArticleRepositoryImpl repository;

  List<ArticleModel> dummyList = [
    ArticleModel(
      id: '',
      title: '',
      url: '',
      imageUrl: '',
      newsSite: '',
      summary: '',
      publishedAt: '',
      updatedAt: '',
      featured: false,
    ),
    ArticleModel(
      id: '',
      title: '',
      url: '',
      imageUrl: '',
      newsSite: '',
      summary: '',
      publishedAt: '',
      updatedAt: '',
      featured: false,
    )
  ];

  setUp(() {
    localDataSource = MockArticleLocalDataSource();
    remoteDataSource = MockArticleRemoteDataSource();
    networkInfo = MockNetworkInfo();

    repository = ArticleRepositoryImpl(
        localDataSource: localDataSource,
        remoteDataSource: remoteDataSource,
        networkInfo: networkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  runTestsOnline(() {
    test('should get a list of articles', () async {
      Future<List<ArticleModel>> future = Future.value(dummyList);

      when(remoteDataSource.getArticles(0)).thenAnswer((_) => future);

      var articles = await repository.getArticles(0);

      verify(remoteDataSource.getArticles(0));

      expect(articles, equals(Right(dummyList)));
    });

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        when(remoteDataSource.getArticles(0)).thenThrow(ServerException());

        final result = await repository.getArticles(0);

        verify(remoteDataSource.getArticles(0));
        expect(result, equals(Left(ServerFailure())));
      },
    );

    test('should get a list of articles when searching', () async {
      Future<List<ArticleModel>> future = Future.value(dummyList);

      when(remoteDataSource.searchArticles('test')).thenAnswer((_) => future);

      var articles = await repository.searchArticles('test');

      verify(remoteDataSource.searchArticles('test'));

      expect(articles, equals(Right(dummyList)));
    });

    test(
        'should get a server failure remote call is unsuccessful while searching',
        () async {
      when(remoteDataSource.searchArticles('test'))
          .thenThrow(ServerException());

      var result = await repository.searchArticles('test');

      verify(remoteDataSource.searchArticles('test'));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  runTestsOffline(() {
    test('should get a network failure when fetching articles', () async {
      var result = await repository.getArticles(0);

      verifyNever(remoteDataSource.getArticles(0));
      expect(result, equals(Left(NetworkFailure())));
    });

    test('should get a network failure when searching articles', () async {
      var result = await repository.searchArticles('test');

      verifyNever(remoteDataSource.searchArticles('test'));
      expect(result, equals(Left(NetworkFailure())));
    });
  });

  group('favorites cache', () {
    test('should get saved articles', () async {
      Future<List<ArticleModel>> future = Future.value(dummyList);

      when(localDataSource.getSavedArticles()).thenAnswer((_) => future);

      var result = await repository.getSavedArticles();

      verify(localDataSource.getSavedArticles());
      expect(result, equals(Right(dummyList)));
    });

    test('should get a CacheFailure if no saved articles', () async {
      when(localDataSource.getSavedArticles()).thenThrow(CacheException());

      var result = await repository.getSavedArticles();

      verify(localDataSource.getSavedArticles());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
