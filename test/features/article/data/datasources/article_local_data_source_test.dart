import 'package:cosmonaut/core/error/exceptions.dart';
import 'package:cosmonaut/features/article/data/datasources/article_local_data_source.dart';
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
}
