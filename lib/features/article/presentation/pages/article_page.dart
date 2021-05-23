import 'package:cosmonaut/core/ui/colors.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticlePage extends StatefulWidget {
  final Article article;
  final Function toggleFavorite;

  const ArticlePage({Key key, this.article, this.toggleFavorite})
      : super(key: key);
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
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
    return widget.toggleFavorite(widget.article);
  }
}
