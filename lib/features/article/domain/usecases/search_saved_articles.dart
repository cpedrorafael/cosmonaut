import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

class SearchSavedArticles implements UseCase<List<Article>, SearchParams> {
  final ArticleRepository repository;

  SearchSavedArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(params) async {
    return await repository.searchSavedArticles(params.term);
  }
}

class SearchParams extends Equatable {
  final String term;

  SearchParams({@required this.term});
  @override
  List<Object> get props => [term];
}
