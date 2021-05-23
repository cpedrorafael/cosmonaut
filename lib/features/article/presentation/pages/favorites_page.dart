import 'package:cosmonaut/features/article/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmoAppBar(
        context: context,
        hasSubtitle: false,
        title: 'Favorites',
        onSearchPressed: (term) {},
      ),
      body: Center(
        child: EmptyFavorites(),
      ),
    );
  }
}
