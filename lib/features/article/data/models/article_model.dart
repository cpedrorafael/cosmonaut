import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  String title, url, imageUrl, newsSite, summary, publishedAt, updatedAt;
  bool featured;

  ArticleModel();

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
