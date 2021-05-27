import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/save_favorite_article.dart';
import 'article_event.dart';
import 'article_state.dart';

const String CACHE_FAILURE_MESSAGE = 'There was a problem loading the articles';

class FavoritesBloc extends Bloc<ArticleEvent, ArticleState> {
  final SaveOrRemoveArticle _saveOrRemove;
  final GetFavorites _getFavorites;

  FavoritesBloc({
    @required SaveOrRemoveArticle saveOrRemove,
    @required GetFavorites getFavorites,
  })  : assert(saveOrRemove != null),
        assert(getFavorites != null),
        _saveOrRemove = saveOrRemove,
        _getFavorites = getFavorites,
        super(null);

  @override
  ArticleState get initialState => Empty();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is GetFavoritesList) {
      yield Loading();

      final failureOrArticles = await _getFavorites(NoParams());

      yield* _eitherLoadedOrErrorState(failureOrArticles);
    } else if (event is ToggleFavoriteArticle) {
      await _saveOrRemove(SaveParams(article: event.article));

      yield ToggledFavorite(article: event.article);
    }
  }

  Stream<ArticleState> _eitherLoadedOrErrorState(
      Either<Failure, List<Article>> failureOrArticles,
      [bool isSearch = false]) async* {
    yield failureOrArticles.fold(
      (failure) => Error(message: CACHE_FAILURE_MESSAGE),
      (articles) => isSearch
          ? SearchResultLoaded(articles: articles)
          : Loaded(articles: articles),
    );
  }
}
