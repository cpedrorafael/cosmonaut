import 'package:flutter/material.dart';

import '../../../../core/ui/colors.dart';

class CosmoBottomNavigation extends StatefulWidget {
  final Function onItemSelected;

  const CosmoBottomNavigation({Key key, this.onItemSelected}) : super(key: key);

  @override
  _CosmoBottomNavigationState createState() => _CosmoBottomNavigationState();
}

class _CosmoBottomNavigationState extends State<CosmoBottomNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              widget.onItemSelected(index);
            },
            currentIndex: _currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: color_indigo,
                  size: 32,
                ),
                label: 'Feed',
                backgroundColor: color_indigo,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                activeIcon: Icon(
                  Icons.favorite,
                  color: color_indigo,
                  size: 32,
                ),
                label: 'Favorites',
              )
            ],
          ),
        ));
  }
}
