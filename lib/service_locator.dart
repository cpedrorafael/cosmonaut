import 'package:cosmonaut/features/article/domain/usecases/get_favorites.dart';
import 'package:cosmonaut/features/article/domain/usecases/save_favorite_article.dart';
import 'package:cosmonaut/features/article/domain/usecases/search_articles.dart';
import 'package:cosmonaut/features/article/presentation/bloc/favorites_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/article/data/datasources/article_local_data_source.dart';
import 'features/article/data/datasources/article_remote_data_source.dart';
import 'features/article/data/repositories/article_repository_impl.dart';
import 'features/article/domain/repositories/article_repository.dart';
import 'features/article/domain/usecases/get_articles.dart';
import 'features/article/presentation/bloc/article_bloc.dart';

final locator = GetIt.instance;

Future setupServiceLocator() async {
  locator.reset();

  //Article bloc
  locator.registerFactory(() => ArticleBloc(
        getArticles: locator(),
        searchArticles: locator(),
        saveOrRemove: locator(),
      ));

  //Favorites bloc
  locator.registerFactory(() => FavoritesBloc(
        saveOrRemove: locator(),
        getFavorites: locator(),
      ));

  //Use cases
  locator.registerLazySingleton(() => GetArticles(locator()));
  locator.registerLazySingleton(() => SearchArticles(locator()));
  locator.registerLazySingleton(() => SaveOrRemoveArticle(locator()));
  locator.registerLazySingleton(() => GetFavorites(locator()));

  //Repository
  locator.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(
        localDataSource: locator(),
        remoteDataSource: locator(),
        networkInfo: locator(),
      ));

  //Data sources
  locator.registerLazySingleton<ArticleLocalDataSource>(
      () => ArticleLocalDataSourceImpl(storage: locator()));

  locator.registerLazySingleton<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSourceImpl(
            client: locator(),
          ));

  //Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  //3rd party libs
  locator.registerLazySingleton(() => FlutterSecureStorage());
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
