import 'package:cosmonaut/features/article/presentation/bloc/article_bloc.dart';
import 'package:cosmonaut/features/article/presentation/pages/feed_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/article/presentation/bloc/article_event.dart';
import 'service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FeedPage(),
    );
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
