import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles(int page);
  Future<Either<Failure, List<Article>>> searchArticles(String term);
  Future<Either<Failure, List<Article>>> getSavedArticles();
  Future<void> saveArticle(Article article);
}
