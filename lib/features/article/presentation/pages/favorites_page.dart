import 'package:cosmonaut/core/utils/utils.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/presentation/bloc/article_bloc.dart';
import 'package:cosmonaut/features/article/presentation/bloc/article_event.dart';
import 'package:cosmonaut/features/article/presentation/bloc/bloc.dart';
import 'package:cosmonaut/features/article/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';
import 'article_page.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var bloc = locator<ArticleBloc>();
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    bloc.add(GetFavoritesList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmoAppBar(
        context: context,
        title: 'Favorites',
        hasSubtitle: true,
        subtitle: 'Favorite articles',
        onSearchPressed: (term) {},
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer(
      cubit: bloc,
      builder: (BuildContext context, state) {
        if (state is Empty)
          return EmptyNews();
        else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Error)
          return ErrorView(message: state.message);
        else if (state is Loaded)
          return _getListView(state.articles);
        else if (state is SearchResultLoaded) {
          if (state.articles.length == 0) return EmptySearch();
          return _getListView(state.articles);
        }
        return EmptyNews();
      },
      listener: (BuildContext context, state) {},
    );
  }

  Widget _getListView(List<Article> articles) {
    _articles.addAll(articles);

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: ListView.builder(
        itemCount: _articles.length,
        addAutomaticKeepAlives: true,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => openArticle(_articles[index], context),
            child: HeadlineWidget(
              article: _articles[index],
              onToggleFavorite: (article) => toggleFavorite(article, bloc),
            ),
          );
        },
      ),
    );
  }
}
