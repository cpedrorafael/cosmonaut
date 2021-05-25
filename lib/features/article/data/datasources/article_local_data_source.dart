import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/article_cache.dart';
import '../models/article_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> getSavedArticles();
  Future<void> saveArticle(ArticleModel article);
  Future<bool> checkArticleSaved(String id);
}

const SAVED_ARTICLES = 'ARTICLES';

class ArticleLocalDataSourceImpl extends ArticleLocalDataSource {
  final FlutterSecureStorage storage;

  ArticleLocalDataSourceImpl({@required this.storage});

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    var cache = await _getCache();
    if (cache.articles.isEmpty) throw CacheException();
    return cache.articles;
  }

  @override
  Future<void> saveArticle(ArticleModel article) async {
    var cache = await _getCache();
    cache.articles.add(article);
    await _saveCache(cache);
  }

  Future<ArticleCache> _getCache() async {
    ArticleCache cache = ArticleCache.empty();
    try {
      var stored = await storage.read(key: SAVED_ARTICLES);
      Map<String, dynamic> map = jsonDecode(stored);
      cache = ArticleCache.fromJson(map);
    } catch (e) {}

    return cache;
  }

  Future<void> _saveCache(ArticleCache cache) async {
    var map = cache.toJson();
    await storage.write(
        key: SAVED_ARTICLES, value: json.decode(map.toString()));
  }

  @override
  Future<bool> checkArticleSaved(String id) async {
    var cache = await _getCache();
    return cache.articles.any((x) => x.id == id);
  }
}
