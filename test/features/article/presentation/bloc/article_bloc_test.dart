import 'package:cosmonaut/core/error/failures.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/domain/usecases/get_articles.dart';
import 'package:cosmonaut/features/article/domain/usecases/search_articles.dart';
import 'package:cosmonaut/features/article/presentation/bloc/article_bloc.dart';
import 'package:cosmonaut/features/article/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_save_or_remove_article.dart';

class MockGetArticles extends Mock implements GetArticles {}

class MockSearchArticles extends Mock implements SearchArticles {}

void main() {
  ArticleBloc bloc;
  MockGetArticles getArticles;
  MockSearchArticles searchArticles;
  MockSaveOrRemoveArticle saveOrRemoveArticle;

  setUp(() {
    getArticles = MockGetArticles();
    searchArticles = MockSearchArticles();
    saveOrRemoveArticle = MockSaveOrRemoveArticle();

    bloc = ArticleBloc(
        getArticles: getArticles,
        searchArticles: searchArticles,
        saveOrRemove: saveOrRemoveArticle);
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetArticles', () {
    List<Article> articles = [];

    setupGetArticles() =>
        when(getArticles(any)).thenAnswer((_) async => Right(articles));

    test('should get data when calling get articles use case', () async {
      setupGetArticles();

      bloc.add(GetArticleList(page: 0));

      await untilCalled(getArticles(any));

      verify(getArticles(Params(page: 0)));
    });

    test('should yield Loading | Loaded when data is retrieved', () async {
      setupGetArticles();

      final expected = [
        Loading(),
        Loaded(articles: articles),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetArticleList(page: 0));
    });

    test('should only emit Loaded when page is not 0', () async {
      setupGetArticles();

      expectLater(bloc, emits(Loaded(articles: articles)));

      bloc.add(GetArticleList(page: 1));
    });

    test('should emit Loading | Error if no data from server', () {
      setupGetArticles();

      when(getArticles(any)).thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetArticleList(page: 0));
    });

    test('should emit Loading | Error with network failure if no internet', () {
      setupGetArticles();

      when(getArticles(any)).thenAnswer((_) async => Left(NetworkFailure()));

      final expected = [
        Loading(),
        Error(message: NETWORK_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetArticleList(page: 0));
    });
  });

  group('Search Articles', () {
    List<Article> articles = [];

    setupSearchArticles() =>
        when(searchArticles(any)).thenAnswer((_) async => Right(articles));

    test('should get data when calling get search result use case', () async {
      setupSearchArticles();

      bloc.add(GetSearchResultList(term: 'test'));

      await untilCalled(searchArticles(any));

      verify(searchArticles(SearchParams(term: 'test')));
    });

    test('should yield Loading | SearchResultLoaded when data is retrieved',
        () async {
      setupSearchArticles();

      final expected = [
        Loading(),
        SearchResultLoaded(articles: articles),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetSearchResultList(term: 'test'));
    });

    test('should emit Loading | Error if no data from server', () {
      setupSearchArticles();

      when(searchArticles(any)).thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetSearchResultList(term: 'test'));
    });

    test('should emit Loading | Error with network failure if no internet', () {
      setupSearchArticles();

      when(searchArticles(any)).thenAnswer((_) async => Left(NetworkFailure()));

      final expected = [
        Loading(),
        Error(message: NETWORK_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetSearchResultList(term: 'test'));
    });
  });
}
