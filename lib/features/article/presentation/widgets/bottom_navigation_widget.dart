import 'package:cosmonaut/core/ui/colors.dart';
import 'package:flutter/material.dart';

class CosmoBottomNavigation extends StatelessWidget {
  final Function onItemSelected;

  const CosmoBottomNavigation({Key key, this.onItemSelected}) : super(key: key);
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
            onTap: onItemSelected,
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
