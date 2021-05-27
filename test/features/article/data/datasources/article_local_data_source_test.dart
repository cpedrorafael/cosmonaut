import 'package:cosmonaut/core/error/exceptions.dart';
import 'package:cosmonaut/features/article/data/datasources/article_local_data_source.dart';
import 'package:cosmonaut/features/article/data/models/article_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  ArticleLocalDataSourceImpl localDataSource;
  MockFlutterSecureStorage storage;

  setUp(() {
    storage = MockFlutterSecureStorage();
    localDataSource = ArticleLocalDataSourceImpl(storage: storage);
  });

  test('should get articles list if has articles', () async {
    Future<String> cache = Future.value(fixture('article_cache.json'));

    when(storage.read(key: SAVED_ARTICLES)).thenAnswer((_) => cache);

    var articles = await localDataSource.getSavedArticles();

    expect(articles.length, greaterThan(0));
  });

  test('should throw a CacheException if has no articles', () async {
    when(storage.read(key: SAVED_ARTICLES)).thenReturn(null);

    expect(() async => localDataSource.getSavedArticles(),
        throwsA(isA<CacheException>()));
  });

  test('should return true if article is saved', () async {
    Future<String> cache = Future.value(fixture('article_cache.json'));

    when(storage.read(key: SAVED_ARTICLES)).thenAnswer((_) => cache);

    var isSaved =
        await localDataSource.checkArticleSaved("60a814a45deb17001cdedcac");

    expect(isSaved, true);
  });

  test('should return false if article is not saved', () async {
    Future<String> cache = Future.value(fixture('article_cache.json'));

    when(storage.read(key: SAVED_ARTICLES)).thenAnswer((_) => cache);

    var isSaved = await localDataSource.checkArticleSaved("");

    expect(isSaved, false);
  });

  group('Search saved articles', () {
    setupCache() => when(storage.read(key: SAVED_ARTICLES))
        .thenAnswer((_) async => fixture('article_cache.json'));

    test('should return a list of saved articles when searching', () async {
      setupCache();
      var articles = await localDataSource.searchSavedArticles('test');

      expect(articles, isA<List<ArticleModel>>());
    });

    test('should return correct articles when searching with search term',
        () async {
      setupCache();

      var articles = await localDataSource.searchSavedArticles('spacex');

      var expectedIds = [
        '60a77a0b5deb17001cdedca1',
        '60a6e6545deb17001cdedc9f',
        '60a6df425deb17001cdedc9d',
        '60a6daa95deb17001cdedc9c',
        '60a626345deb17001cdedc91',
      ];

      expect(articles.length, 5);
      expect(articles.map((e) => e.id).toList(), containsAll(expectedIds));
    });

    test('should throw CacheException when there are no matches', () async {
      setupCache();

      var call = localDataSource.searchSavedArticles(
          'asdfasasdfasdfadasdfadfasfadfadsfasdfasdfadsfxzcvzcadfg()*)(*()&');

      expect(() async => call, throwsA(isA<CacheException>()));
    });
  });
}
