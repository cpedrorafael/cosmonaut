import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Article extends Equatable {
  final String id,
      title,
      url,
      imageUrl,
      newsSite,
      summary,
      publishedAt,
      updatedAt;
  final bool featured;
  bool isFavorite;

  Article({
    @required this.id,
    @required this.title,
    @required this.url,
    @required this.imageUrl,
    @required this.newsSite,
    @required this.summary,
    @required this.publishedAt,
    @required this.updatedAt,
    @required this.featured,
  }) : this.isFavorite = false;

  @override
  List<Object> get props => [
        id,
        title,
        url,
        imageUrl,
        newsSite,
        summary,
        publishedAt,
        updatedAt,
        featured,
        isFavorite
      ];
}
