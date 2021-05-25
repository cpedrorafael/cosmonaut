import 'package:cosmonaut/core/utils/utils.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/presentation/bloc/bloc.dart';
import 'package:cosmonaut/features/article/presentation/pages/article_page.dart';
import 'package:cosmonaut/features/article/presentation/widgets/widgets.dart';
import 'package:cosmonaut/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  var bloc = locator<ArticleBloc>();
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
          _isSearching = true;
          _articles.clear();
          bloc.add(GetSearchResultList(term: term));
        },
        onSearchClosed: _resetFeed,
      ),
      body: _getBody(context),
    );
  }

  void _resetFeed() {
    _isSearching = false;
    _articles.clear();
    _page = 0;
    bloc.add(GetArticleList(page: _page));
  }

  @override
  void dispose() {
    bloc.close();
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
    bloc.add(GetArticleList(page: _page));
  }

  Widget _getBody(context) {
    return BlocListener<ArticleBloc, ArticleState>(
      cubit: bloc,
      listener: (BuildContext context, state) {
        if (state is Loaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              if (_scrollPosition != null)
                _controller.jumpTo(_scrollPosition.pixels);
            }
          });
        }
      },
      child: BlocProvider<ArticleBloc>(
        create: (_) => bloc,
        child: Center(
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
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
          ),
        ),
      ),
    );
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

  void _onListEndReached() {
    if (_controller.offset == _controller.position.maxScrollExtent &&
        !_isSearching) {
      _scrollPosition = _controller.position;
      bloc.add(GetArticleList(page: _page));
    }
  }
}
