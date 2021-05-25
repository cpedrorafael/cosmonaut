import 'package:cosmonaut/core/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CosmoAppBar extends PreferredSize {
  final String title;
  final String subtitle;
  final bool hasSubtitle;
  final Function onSearchPressed;
  final BuildContext context;
  final Function onSearchClosed;

  CosmoAppBar({
    this.title,
    this.subtitle,
    this.hasSubtitle,
    this.onSearchPressed,
    this.context,
    this.onSearchClosed,
  }) : super(
            preferredSize: Size(double.infinity, 160),
            child: ExpandableBar(
              title: title,
              onSearchPressed: onSearchPressed,
              onSearchClosed: onSearchClosed,
              context: context,
              subtitle: subtitle,
              hasSubtitle: hasSubtitle,
            ));
}

class ExpandableBar extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool hasSubtitle;
  final Function onSearchPressed;
  final Function onSearchClosed;
  final BuildContext context;
  const ExpandableBar({
    Key key,
    this.title,
    this.subtitle,
    this.hasSubtitle,
    this.onSearchPressed,
    this.context,
    this.onSearchClosed,
  }) : super(key: key);

  @override
  _ExpandableBarState createState() => _ExpandableBarState();
}

class _ExpandableBarState extends State<ExpandableBar> {
  double _topContainerHeight = 150;
  double _bottomContainerHeight = 80;
  double _searchContainerHeight = 0;
  double _searchContainerWidth = 0;
  bool _isSearching = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: _topContainerHeight,
          decoration: BoxDecoration(color: color_indigo),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                Theme.of(context).textTheme.headline5.fontSize,
                            color: Colors.white),
                      ),
                      InkWell(
                        child: Icon(
                          _isSearching ? Icons.close : Icons.search,
                          color: Colors.white,
                        ),
                        onTap: search,
                      )
                    ],
                  ),
                  SizedBox(
                    height: _isSearching ? 16 : 0,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: _searchContainerHeight,
                    width: _searchContainerWidth,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: _isSearching
                          ? TextField(
                              controller: _controller,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .fontSize,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontSize,
                                ),
                                filled: true,
                                fillColor: color_transparent_grey,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30.0),
                                    ),
                                    borderSide: BorderSide.none),
                              ),
                              onChanged: onSearchPressed,
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              height: _bottomContainerHeight,
              color: Theme.of(context).canvasColor,
              child: Center(
                child: widget.hasSubtitle
                    ? Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            child: Text(
                              widget.subtitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .fontSize),
                            ),
                          )
                        ],
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void search() {
    _isSearching = !_isSearching;
    setState(() {
      _topContainerHeight = _isSearching ? 220 : 150;
      _bottomContainerHeight = _isSearching ? 15 : 80;
      _searchContainerHeight = _isSearching ? 62 : 0;
      _searchContainerWidth =
          _isSearching ? MediaQuery.of(context).size.width : 0;
    });
    if (!_isSearching) widget.onSearchClosed();
    _controller.clear();
  }

  void onSearchPressed(String value) => widget.onSearchPressed(value);
}
