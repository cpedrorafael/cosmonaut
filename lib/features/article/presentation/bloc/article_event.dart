import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/article.dart';

@immutable
abstract class ArticleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetArticleList extends ArticleEvent {
  final int page;
  GetArticleList({@required this.page});

  @override
  List<Object> get props => [page];
}

class GetSearchResultList extends ArticleEvent {
  final String term;
  GetSearchResultList({@required this.term});

  @override
  List<Object> get props => [term];
}

class ToggleFavoriteArticle extends ArticleEvent {
  final Article article;
  ToggleFavoriteArticle({@required this.article});

  @override
  List<Object> get props => [article];
}

class GetFavoritesList extends ArticleEvent {
  GetFavoritesList();

  @override
  List<Object> get props => [];
}
