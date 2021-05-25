import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';

class GetFavorites implements UseCase<List<Article>, NoParams> {
  final ArticleRepository repository;

  GetFavorites(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await repository.getSavedArticles();
  }
}
