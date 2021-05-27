import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

class GetArticles implements UseCase<List<Article>, Params> {
  final ArticleRepository repository;

  GetArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(params) async {
    return await repository.getArticles(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({@required this.page});
  @override
  List<Object> get props => [page];
}
