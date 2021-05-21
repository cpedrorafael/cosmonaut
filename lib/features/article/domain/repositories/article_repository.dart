import 'package:cosmonaut/core/error/failures.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
  Future<Either<Failure, List<Article>>> searchArticles(String term);
  Future<Either<Failure, List<Article>>> getSavedArticles();
  Future<void> saveArticle(Article article);
}
