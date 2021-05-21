// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleCache _$ArticleCacheFromJson(Map<String, dynamic> json) {
  return ArticleCache()
    ..articles = (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : ArticleModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ArticleCacheToJson(ArticleCache instance) =>
    <String, dynamic>{
      'articles': instance.articles,
    };
