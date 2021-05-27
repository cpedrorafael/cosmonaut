import 'package:cosmonaut/features/article/domain/usecases/search_saved_articles.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dummy_articles.dart';
import 'mock_article_repository.dart';

void main() {
  SearchSavedArticles usecase;
  MockArticleRepository repository;

  setUp(() {
    repository = MockArticleRepository();
    usecase = SearchSavedArticles(repository);
  });

  test('should get a list of saved articles from the repository when searching',
      () async {
    when(repository.searchSavedArticles(any))
        .thenAnswer((_) async => Right(dummyList));

    var result = await usecase(SearchParams(term: 'test'));

    verify(repository.searchSavedArticles('test'));
    verifyNoMoreInteractions(repository);
    expect(result, Right(dummyList));
  });
}
