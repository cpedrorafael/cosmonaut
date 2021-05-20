import 'dart:convert';

import 'package:cosmonaut/core/error/exceptions.dart';
import 'package:cosmonaut/core/network/endpoints.dart';
import 'package:cosmonaut/features/article/data/models/article_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
  Future<List<ArticleModel>> searchArticles();
}

class ArticleRemoteDataSourceImpl extends ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl({@required this.client});
  @override
  Future<List<ArticleModel>> getArticles() async {
    return await _getArticlesFromUrl(articlesURL);
  }

  @override
  Future<List<ArticleModel>> searchArticles() {
    // TODO: implement searchHeadlines
    throw ServerException();
  }

  Future<List<ArticleModel>> _getArticlesFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<ArticleModel> list = [];
      for (var item in json.decode(response.body)) {
        list.add(ArticleModel.fromJson(item));
      }
      return list;
    } else {
      throw ServerException();
    }
  }
}
