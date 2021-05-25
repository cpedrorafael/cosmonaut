import 'dart:math';

import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/domain/repositories/article_repository.dart';
import 'package:cosmonaut/features/article/domain/usecases/get_articles.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dummy_articles.dart';
import 'mock_article_repository.dart';

void main() {
  GetArticles usecase;
  MockArticleRepository repository;

  setUp(() {
    repository = MockArticleRepository();
    usecase = GetArticles(repository);
  });

  test('should get a list of articles from the repository', () async {
    when(repository.getArticles(0)).thenAnswer((_) async => Right(dummyList));

    var result = await usecase(Params(page: 0));

    verify(repository.getArticles(0));
    verifyNoMoreInteractions(repository);
    expect(result, Right(dummyList));
  });
}
