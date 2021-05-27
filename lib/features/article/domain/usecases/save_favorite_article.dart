import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

class SaveOrRemoveArticle implements UseCase<void, SaveParams> {
  final ArticleRepository repository;

  SaveOrRemoveArticle(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    await repository.saveorDeleteArticle(params.article);
    return null;
  }
}

class SaveParams extends Equatable {
  final Article article;

  SaveParams({@required this.article});
  @override
  List<Object> get props => [article];
}
