import 'package:flutter/material.dart';

import 'features/article/presentation/pages/favorites_page.dart';
import 'features/article/presentation/pages/feed_page.dart';
import 'features/article/presentation/widgets/widgets.dart';
import 'service_locator.dart';

void main() async {
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  FeedPage _feedPage = FeedPage();

  FavoritesPage _favoritesPage = FavoritesPage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'IBMPlexSans',
      ),
      home: Scaffold(
        body: _getCurrentPage(_currentIndex),
        bottomNavigationBar: CosmoBottomNavigation(
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _getCurrentPage(int index) {
    if (index == 0)
      return _feedPage;
    else if (index == 1)
      return _favoritesPage;
    else
      return Container();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container());
  }
}
