import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/core/error/failures.dart';
import 'package:cosmonaut/features/article/domain/usecases/get_articles.dart';
import 'package:cosmonaut/features/article/presentation/bloc/article_event.dart';
import 'package:cosmonaut/features/article/presentation/bloc/article_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'There was an error. Please try again.';
const String NETWORK_FAILURE_MESSAGE = 'No internet connection';
const String CACHE_FAILURE_MESSAGE = 'There was a problem loading the articles';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticles _getArticles;

  ArticleBloc({@required GetArticles getArticles})
      : assert(getArticles != null),
        _getArticles = getArticles,
        super(null);

  @override
  ArticleState get initialState => Empty();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is GetArticleList) {
      yield Loading();

      final failureOrArticles = await _getArticles(Params(page: event.page));

      yield* _eitherLoadedOrErrorState(failureOrArticles);
    }
  }

  Stream<ArticleState> _eitherLoadedOrErrorState(
      Either<Failure, List<Article>> failureOrArticles) async* {
    yield failureOrArticles.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (articles) => Loaded(articles: articles));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Oops! There was an error.';
    }
  }
}
