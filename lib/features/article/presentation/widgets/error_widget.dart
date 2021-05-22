import 'package:flutter/widgets.dart';

class ErrorView extends StatelessWidget {
  final String message;

  const ErrorView({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}
