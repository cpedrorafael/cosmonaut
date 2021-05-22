import 'package:cosmonaut/features/article/data/datasources/article_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  ArticleLocalDataSourceImpl localDataSource;
  MockFlutterSecureStorage storage;

  setUp(() {
    storage = MockFlutterSecureStorage();
    localDataSource = ArticleLocalDataSourceImpl(storage: storage);
  });
}
