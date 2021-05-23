import 'package:flutter/material.dart';

class EmptySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(10, 0, 0, 0),
            child: Icon(
              Icons.search,
              color: Colors.black12,
              size: 72,
            ),
            radius: 100,
          ),
        ),
        Text(
          "There are no results for this search.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          "Try searching another word.",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
