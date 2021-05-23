import 'package:cosmonaut/core/ui/colors.dart';
import 'package:flutter/material.dart';

class EmptyFavorites extends StatelessWidget {
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
              Icons.favorite,
              color: Colors.black12,
              size: 72,
            ),
            radius: 100,
          ),
        ),
        Text(
          "You don't have favorites yet.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tap on the ",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Icon(
              Icons.favorite_border_outlined,
              color: color_indigo,
            ),
            Text(
              " to mark an article as favorite.",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
