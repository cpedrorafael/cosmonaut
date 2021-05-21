import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Article extends Equatable {
  final String title, url, imageUrl, newsSite, summary, publishedAt, updatedAt;
  final bool featured;

  Article({
    @required this.title,
    @required this.url,
    @required this.imageUrl,
    @required this.newsSite,
    @required this.summary,
    @required this.publishedAt,
    @required this.updatedAt,
    @required this.featured,
  });

  @override
  List<Object> get props => [
        title,
        url,
        imageUrl,
        newsSite,
        summary,
        publishedAt,
        updatedAt,
        featured,
      ];
}
