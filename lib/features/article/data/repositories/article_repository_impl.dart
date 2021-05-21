import 'package:cosmonaut/core/network/network_info.dart';
import 'package:cosmonaut/features/article/data/datasources/article_local_data_source.dart';
import 'package:cosmonaut/features/article/data/datasources/article_remote_data_source.dart';
import 'package:cosmonaut/features/article/data/models/article_model.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/core/error/failures.dart';
import 'package:cosmonaut/features/article/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final ArticleLocalDataSource localDataSource;
  final ArticleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Article>>> getArticles() {
    // TODO: implement getArticles
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Article>>> searchArticles(String term) {
    // TODO: implement searchArticles
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Article>>> getSavedArticles() {
    // TODO: implement getSavedArticles
    throw UnimplementedError();
  }

  @override
  Future<void> saveArticle(Article article) async {
    await localDataSource.saveArticle(_articleToModel(article));
  }

  ArticleModel _articleToModel(Article article) => ArticleModel.fromProps(
      article.title,
      article.url,
      article.imageUrl,
      article.newsSite,
      article.summary,
      article.publishedAt,
      article.updatedAt);
}
