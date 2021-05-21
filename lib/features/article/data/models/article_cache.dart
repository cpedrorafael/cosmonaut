import 'package:cosmonaut/features/article/data/models/article_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_cache.g.dart';

@JsonSerializable()
class ArticleCache {
  List<ArticleModel> articles;

  ArticleCache();
  ArticleCache.empty() : articles = [];

  factory ArticleCache.fromJson(Map<String, dynamic> json) =>
      _$ArticleCacheFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleCacheToJson(this);
}
