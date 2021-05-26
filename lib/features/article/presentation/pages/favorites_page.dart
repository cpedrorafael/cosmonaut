import 'package:cosmonaut/core/utils/utils.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/presentation/bloc/article_event.dart';
import 'package:cosmonaut/features/article/presentation/bloc/bloc.dart';
import 'package:cosmonaut/features/article/presentation/bloc/favorites_bloc.dart';
import 'package:cosmonaut/features/article/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var bloc = locator<FavoritesBloc>();

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
    return Center(
      child: BlocListener(
        cubit: bloc,
        listener: (BuildContext context, state) {
          if (state is ToggledFavorite) bloc.add(GetFavoritesList());
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
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: ListView(
          children: articles
              .map(
                (e) => InkWell(
                  onTap: () => openArticle(e, context),
                  child: HeadlineWidget(
                    article: e,
                    onToggleFavorite: (article) =>
                        toggleFavorite(article, bloc),
                  ),
                ),
              )
              .toList(),
        ));
  }
}
