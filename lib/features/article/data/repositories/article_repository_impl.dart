import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/article_local_data_source.dart';
import '../datasources/article_remote_data_source.dart';
import '../models/article_model.dart';

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
  Future<Either<Failure, List<Article>>> getArticles(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.getArticles(page);
        await _checkForFavorites(remoteArticles);
        return Right(remoteArticles);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(NetworkFailure());
  }

  Future _checkForFavorites(List<ArticleModel> remoteArticles) async {
    for (var item in remoteArticles) {
      item.isFavorite = await localDataSource.checkArticleSaved(item.id);
    }
  }

  @override
  Future<Either<Failure, List<Article>>> searchArticles(String term) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.searchArticles(term);
        await _checkForFavorites(remoteArticles);
        return Right(remoteArticles);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<Article>>> getSavedArticles() async {
    try {
      final savedArticles = await localDataSource.getSavedArticles();
      return Right(savedArticles);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> saveorDeleteArticle(Article article) async {
    await localDataSource.saveOrDeleteArticle(article);
  }
}
