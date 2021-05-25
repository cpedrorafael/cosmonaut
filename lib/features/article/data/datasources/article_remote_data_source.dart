import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/endpoints.dart';
import '../models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles(int page);
  Future<List<ArticleModel>> searchArticles(String term);
}

class ArticleRemoteDataSourceImpl extends ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl({@required this.client});
  @override
  Future<List<ArticleModel>> getArticles(int page) async {
    return await _getArticlesFromUrl(articlesURL, page);
  }

  @override
  Future<List<ArticleModel>> searchArticles(String term) async {
    if (term == null || term.isEmpty) return [];
    return await _getArticlesFromUrl(articlesURL, 0, true, term);
  }

  Future<List<ArticleModel>> _getArticlesFromUrl(String url, int page,
      [bool isSearch = false, String searchTerm = '']) async {
    var start = page * 10;
    var queryString = "$url?_limit=10&_start=$start";
    if (isSearch)
      queryString += "&title_contains=$searchTerm&summary_contains=$searchTerm";

    final response = await client.get(
      queryString,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
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
