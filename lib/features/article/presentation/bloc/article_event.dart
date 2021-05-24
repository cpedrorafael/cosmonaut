import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
