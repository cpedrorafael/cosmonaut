import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/domain/usecases/save_favorite_article.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_article_repository.dart';

void main() {
  SaveOrRemoveArticle usecase;
  MockArticleRepository repository;

  setUp(() {
    repository = MockArticleRepository();
    usecase = SaveOrRemoveArticle(repository);
  });

  test('should save an article in the repository', () async {
    Article article = Article(
      id: 'test',
      title: 'test',
      url: 'test',
      imageUrl: 'test',
      newsSite: 'test',
      summary: 'test',
      publishedAt: 'test',
      updatedAt: 'test',
      featured: false,
    );

    when(repository.saveorDeleteArticle(any))
        .thenAnswer((_) async => Right(article));

    await usecase(SaveParams(article: article));

    verify(repository.saveorDeleteArticle(article));
    verifyNoMoreInteractions(repository);
  });
}
