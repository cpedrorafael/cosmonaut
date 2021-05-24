import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/article.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends Article {
  ArticleModel({
    @required String id,
    @required String title,
    @required String url,
    @required String imageUrl,
    @required String newsSite,
    @required String summary,
    @required String publishedAt,
    @required String updatedAt,
    @required bool featured,
  }) : super(
          id: id,
          title: title,
          url: url,
          imageUrl: imageUrl,
          newsSite: newsSite,
          summary: summary,
          publishedAt: publishedAt,
          updatedAt: updatedAt,
          featured: featured,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
