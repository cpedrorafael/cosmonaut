import 'package:cosmonaut/core/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CosmoAppBar extends AppBar {
  final Widget title;
  final Function onSearchPressed;
  CosmoAppBar({
    this.title,
    this.onSearchPressed,
  }) : super(
          title: title,
          centerTitle: false,
          actions: [
            InkWell(
              child: Icon(
                Icons.search,
              ),
              onTap: () {},
            ),
          ],
          backgroundColor: color_indigo,
        );
}
