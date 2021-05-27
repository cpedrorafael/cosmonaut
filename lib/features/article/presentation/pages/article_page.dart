import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../../../core/ui/colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/article.dart';
import '../bloc/favorites_bloc.dart';
import '../widgets/widgets.dart';

class ArticlePage extends StatefulWidget {
  final Article article;
  final Function onToggleFavorite;

  const ArticlePage({
    Key key,
    this.article,
    this.onToggleFavorite,
  }) : super(key: key);
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  var favorites_bloc = locator<FavoritesBloc>();

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.article.url,
      appBar: AppBar(
        backgroundColor: color_dark_blue,
        title: Text('Article'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(widget.article.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              onTap: _toggleFavorite,
            ),
          )
        ],
      ),
      initialChild: Center(
        child: LoadingWidget(),
      ),
      appCacheEnabled: true,
      withJavascript: false,
    );
  }

  _toggleFavorite() {
    setState(() {
      widget.article.isFavorite = !widget.article.isFavorite;
    });
    toggleFavorite(widget.article, favorites_bloc);
    if (widget.onToggleFavorite != null)
      widget.onToggleFavorite(widget.article);
  }
}
