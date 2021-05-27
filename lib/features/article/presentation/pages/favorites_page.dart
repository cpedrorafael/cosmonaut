import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utils.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/article.dart';
import '../bloc/article_event.dart';
import '../bloc/bloc.dart';
import '../bloc/favorites_bloc.dart';
import '../widgets/widgets.dart';
import 'article_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var bloc = locator<FavoritesBloc>();
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _resetBloc();
  }

  void _resetBloc() {
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
        onSearchPressed: (term) {
          if (term.length == 0) return _resetBloc();
          if (term.length < 3) return;
          _startSearch(term);
        },
        onSearchClosed: _resetBloc,
      ),
      body: _buildBody(),
    );
  }

  void _startSearch(term) {
    _articles.clear();
    bloc.add(GetSearchResultList(term: term));
  }

  Widget _buildBody() {
    return Center(
      child: BlocListener(
        cubit: bloc,
        listener: (BuildContext context, state) {
          if (state is ToggledFavorite) _articles.remove(state.article);
        },
        child: BlocProvider(
          create: (_) => bloc,
          child: BlocBuilder<FavoritesBloc, ArticleState>(
            builder: (context, state) {
              if (state is Empty)
                return EmptyFavorites();
              else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded)
                return _getListView(state.articles);
              else if (state is SearchResultLoaded) {
                if (state.articles.length == 0) return EmptySearch();
                return _getListView(state.articles);
              }
              return EmptyFavorites();
            },
          ),
        ),
      ),
    );
  }

  Widget _getListView(List<Article> articles) {
    _articles = articles;
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: ListView.builder(
          itemCount: _articles.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => openArticle(context, index),
            child: HeadlineWidget(
              article: _articles[index],
              onToggleFavorite: (article) => toggleFavorite(article, bloc),
            ),
          ),
        ));
  }

  Future<void> openArticle(BuildContext context, int index) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArticlePage(
                  article: _articles[index],
                ))).then((value) => _resetBloc());
  }
}
