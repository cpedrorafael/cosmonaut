import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/presentation/bloc/bloc.dart';
import 'package:cosmonaut/features/article/presentation/pages/article_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

toggleFavorite(Article article, Bloc bloc) =>
    bloc.add(ToggleFavoriteArticle(article: article));

openArticle(Article e, BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ArticlePage(
              article: e,
              toggleFavorite: toggleFavorite,
            )));
