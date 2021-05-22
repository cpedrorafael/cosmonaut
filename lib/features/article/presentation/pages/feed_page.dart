import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/presentation/bloc/bloc.dart';
import 'package:cosmonaut/features/article/presentation/widgets/widgets.dart';
import 'package:cosmonaut/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int page = 0;

  var bloc = locator<ArticleBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmoAppBar(
        title: Text("Feed"),
      ),
      body: _getBody(context),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getFeed();
  }

  _getFeed() {
    bloc.add(GetArticleList(page));
  }

  Widget _getBody(context) {
    return BlocProvider<ArticleBloc>(
      create: (_) => bloc,
      child: Center(
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is Empty)
              return EmptyNews();
            else if (state is Loading)
              return LoadingWidget();
            else if (state is Error)
              return ErrorView(message: state.message);
            else if (state is Loaded) return _getListView(state.articles);
            return EmptyNews();
          },
        ),
      ),
    );
  }

  Widget _getListView(List<Article> articles) {
    return ListView(
      children: articles
          .map((e) => ListTile(
                title: Text(e.title),
              ))
          .toList(),
    );
  }
}
