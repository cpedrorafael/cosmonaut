import 'package:cosmonaut/core/error/failures.dart';
import 'package:cosmonaut/core/usecases/usecase.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/domain/usecases/get_favorites.dart';
import 'package:cosmonaut/features/article/domain/usecases/search_saved_articles.dart';
import 'package:cosmonaut/features/article/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_save_or_remove_article.dart';

class MockGetFavorites extends Mock implements GetFavorites {}

class MockSearchSavedArticles extends Mock implements SearchSavedArticles {}

void main() {
  FavoritesBloc bloc;
  MockGetFavorites getFavorites;
  MockSaveOrRemoveArticle saveOrRemoveArticle;
  SearchSavedArticles searchSavedArticles;

  setUp(() {
    getFavorites = MockGetFavorites();
    saveOrRemoveArticle = MockSaveOrRemoveArticle();
    searchSavedArticles = MockSearchSavedArticles();

    bloc = FavoritesBloc(
        getFavorites: getFavorites,
        saveOrRemove: saveOrRemoveArticle,
        searchSavedArticles: searchSavedArticles);
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetFavorites', () {
    List<Article> articles = [];

    setupGetFavorites() =>
        when(getFavorites(any)).thenAnswer((_) async => Right(articles));

    test('should get data when calling get favorites use case', () async {
      setupGetFavorites();

      bloc.add(GetFavoritesList());

      await untilCalled(getFavorites(any));

      verify(getFavorites(NoParams()));
    });

    test('should yield Loading | Loaded when data is retrieved', () async {
      setupGetFavorites();

      final expected = [
        Loading(),
        Loaded(articles: articles),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetFavoritesList());
    });

    test('should emit Loading | Error if no data from server', () {
      setupGetFavorites();

      when(getFavorites(any)).thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetFavoritesList());
    });
  });
  group('SaveOrRemoveArticle', () {
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

    setupSaveOrRemoveArticle() =>
        when(saveOrRemoveArticle(any)).thenAnswer((_) async => Right(article));

    test('should emit ToggledFavorite', () {
      setupSaveOrRemoveArticle();

      expectLater(bloc, emits(ToggledFavorite(article: article)));

      bloc.add(ToggleFavoriteArticle(article: article));
    });
  });

  group('Search Articles', () {
    List<Article> articles = [];

    setupSearchSavedArticles() =>
        when(searchSavedArticles(any)).thenAnswer((_) async => Right(articles));

    test('should get data when calling get search result use case', () async {
      setupSearchSavedArticles();

      bloc.add(GetSearchResultList(term: 'test'));

      await untilCalled(searchSavedArticles(any));

      verify(searchSavedArticles(SearchParams(term: 'test')));
    });

    test('should yield Loading | SearchResultLoaded when data is retrieved',
        () async {
      setupSearchSavedArticles();

      final expected = [
        Loading(),
        SearchResultLoaded(articles: articles),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetSearchResultList(term: 'test'));
    });
  });
}
