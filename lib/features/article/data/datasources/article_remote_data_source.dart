import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/endpoints.dart';
import '../models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles(int page);
  Future<List<ArticleModel>> searchArticles();
}

class ArticleRemoteDataSourceImpl extends ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl({@required this.client});
  @override
  Future<List<ArticleModel>> getArticles(int page) async {
    return await _getArticlesFromUrl(articlesURL, page);
  }

  @override
  Future<List<ArticleModel>> searchArticles() {
    // TODO: implement searchHeadlines
    throw ServerException();
  }

  Future<List<ArticleModel>> _getArticlesFromUrl(String url, int page) async {
    var queryString = "$url?_limit=10&_start=$page";

    final response = await client.get(
      queryString,
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
