import 'package:cosmonaut/core/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CosmoAppBar extends PreferredSize {
  final String title;
  final Function onSearchPressed;
  final BuildContext context;
  CosmoAppBar({
    this.title,
    this.onSearchPressed,
    this.context,
  }) : super(
            preferredSize: Size(double.infinity, 150),
            child: Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(color: color_indigo),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .fontSize,
                                color: Colors.white),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Container(
                      height: 80,
                      color: Theme.of(context).canvasColor,
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              child: Text(
                                'News Feed',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .fontSize),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ));
}
