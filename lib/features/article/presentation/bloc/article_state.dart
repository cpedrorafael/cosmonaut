import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/article.dart';

@immutable
abstract class ArticleState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ArticleState {}

class Loading extends ArticleState {}

class Loaded extends ArticleState {
  final List<Article> articles;

  Loaded({@required this.articles});

  @override
  List<Object> get props => [articles];
}

class SearchResultLoaded extends ArticleState {
  final List<Article> articles;

  SearchResultLoaded({@required this.articles});

  @override
  List<Object> get props => [articles];
}

class Error extends ArticleState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

class ToggledFavorite extends ArticleState {
  final Article article;
  ToggledFavorite({@required this.article});
  @override
  List<Object> get props => [article];
}
