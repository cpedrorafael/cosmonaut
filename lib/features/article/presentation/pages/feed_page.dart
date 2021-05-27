import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utils.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/article.dart';
import '../bloc/bloc.dart';
import '../bloc/favorites_bloc.dart';
import '../widgets/widgets.dart';
import 'article_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key key}) : super(key: key);
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  var _bloc = locator<ArticleBloc>();

  var _favoritesBloc = locator<FavoritesBloc>();

  List<Article> _articles = [];

  ScrollController _controller = ScrollController();

  int _page = 0;

  ScrollPosition _scrollPosition;

  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmoAppBar(
        title: 'Feed',
        context: context,
        subtitle: 'News Feed',
        hasSubtitle: true,
        onSearchPressed: (term) {
          if (term.length == 0) return _resetFeed();
          if (term.length < 3) return;
          _startSearch(term);
        },
        onSearchClosed: _resetFeed,
      ),
      body: _getBody(context),
    );
  }

  void _startSearch(term) {
    _isSearching = true;
    _articles.clear();
    _bloc.add(GetSearchResultList(term: term));
  }

  void _resetFeed([bool savePosition = false]) {
    if (savePosition) _saveScrollPosition();
    _isSearching = false;
    _articles.clear();
    _page = 0;
    _bloc.add(GetArticleList(page: _page));
  }

  @override
  void dispose() {
    _bloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getFeed();

    _controller.addListener(() {
      _onListEndReached();
    });
  }

  _getFeed() {
    _bloc.add(GetArticleList(page: _page));
  }

  Widget _getBody(context) {
    return BlocListener<ArticleBloc, ArticleState>(
      cubit: _bloc,
      listener: (BuildContext context, state) {
        if (state is Loaded) _goToCurrentScrollPosition();
      },
      child: BlocProvider<ArticleBloc>(
        create: (_) => _bloc,
        child: Center(
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is Loading) {
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
          ),
        ),
      ),
    );
  }

  void _goToCurrentScrollPosition() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _recoverScrollPosition());
  }

  Widget _getListView(List<Article> articles) {
    _articles.addAll(articles);
    _page++;

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: ListView.builder(
        itemCount: _articles.length,
        addAutomaticKeepAlives: true,
        controller: _controller,
        itemBuilder: (_, index) {
          return _getListViewItem(index);
        },
      ),
    );
  }

  InkWell _getListViewItem(int index) {
    return InkWell(
      onTap: () => openArticle(
          article: _articles[index],
          context: context,
          onToggleFavorite: (_) => _resetFeed(true)),
      child: HeadlineWidget(
        article: _articles[index],
        onToggleFavorite: (article) => toggleFavorite(article, _favoritesBloc),
      ),
    );
  }

  openArticle(
          {Article article,
          BuildContext context,
          Function onToggleFavorite,
          Function onPopBackStack}) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(
                    article: article,
                    onToggleFavorite: onToggleFavorite,
                  ))).then((value) => onPopBackStack);

  void _onListEndReached() {
    if (_controller.offset == _controller.position.maxScrollExtent &&
        !_isSearching) {
      _saveScrollPosition();
      _bloc.add(GetArticleList(page: _page));
    }
  }

  void _saveScrollPosition() {
    _scrollPosition = _controller.position;
  }

  _recoverScrollPosition() {
    if (_controller.hasClients && _scrollPosition != null) {
      _controller.jumpTo(_scrollPosition.pixels);
    }
  }
}
