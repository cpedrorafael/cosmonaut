// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) {
  return ArticleModel()
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..imageUrl = json['imageUrl'] as String
    ..newsSite = json['newsSite'] as String
    ..summary = json['summary'] as String
    ..publishedAt = json['publishedAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..featured = json['featured'] as bool;
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'imageUrl': instance.imageUrl,
      'newsSite': instance.newsSite,
      'summary': instance.summary,
      'publishedAt': instance.publishedAt,
      'updatedAt': instance.updatedAt,
      'featured': instance.featured,
    };