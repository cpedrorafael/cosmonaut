import 'package:cosmonaut/features/article/domain/usecases/search_articles.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dummy_articles.dart';
import 'mock_article_repository.dart';

void main() {
  SearchArticles usecase;
  MockArticleRepository repository;

  setUp(() {
    repository = MockArticleRepository();
    usecase = SearchArticles(repository);
  });

  test('should get a list of articles from the repository when searching',
      () async {
    when(repository.searchArticles('test'))
        .thenAnswer((_) async => Right(dummyList));

    var result = await usecase(SearchParams(term: 'test'));

    verify(repository.searchArticles('test'));
    verifyNoMoreInteractions(repository);
    expect(result, Right(dummyList));
  });
}
