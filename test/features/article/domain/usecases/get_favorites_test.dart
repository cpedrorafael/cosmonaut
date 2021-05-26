import 'package:cosmonaut/core/usecases/usecase.dart';
import 'package:cosmonaut/features/article/domain/usecases/get_articles.dart';
import 'package:cosmonaut/features/article/domain/usecases/get_favorites.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dummy_articles.dart';
import 'mock_article_repository.dart';

void main() {
  GetFavorites usecase;
  MockArticleRepository repository;

  setUp(() {
    repository = MockArticleRepository();
    usecase = GetFavorites(repository);
  });

  test('should get a list of favorite articles from the repository', () async {
    when(repository.getSavedArticles())
        .thenAnswer((_) async => Right(dummyList));

    var result = await usecase(NoParams());

    verify(repository.getSavedArticles());
    verifyNoMoreInteractions(repository);
    expect(result, Right(dummyList));
  });
}
