import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmonaut/core/ui/colors.dart';
import 'package:cosmonaut/features/article/domain/entities/article.dart';
import 'package:cosmonaut/features/article/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../../../core/extensions/string_extensions.dart';

class HeadlineWidget extends StatefulWidget {
  final Article article;
  final Function onToggleFavorite;

  const HeadlineWidget({Key key, this.article, this.onToggleFavorite})
      : super(key: key);

  @override
  _HeadlineWidgetState createState() => _HeadlineWidgetState();
}

class _HeadlineWidgetState extends State<HeadlineWidget> {
  Article _article;
  @override
  void initState() {
    super.initState();
    _article = widget.article;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 350,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Stack(fit: StackFit.expand, children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: widget.article.imageUrl,
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.fitHeight,
                  placeholder: (c, s) {
                    return Center(child: LoadingWidget());
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Container(
                  height: 120,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.article.title),
                        Stack(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(widget.article.publishedAt
                                    .getFormattedDateString()),
                              ],
                            ),
                            Center(
                              child: InkWell(
                                child: Icon(
                                  widget.article.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: widget.article.isFavorite
                                      ? color_indigo
                                      : Colors.grey,
                                ),
                                onTap: toggleFavorite,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void toggleFavorite() {
    setState(() {
      _article.isFavorite = !_article.isFavorite;
    });
    widget.onToggleFavorite(widget.article);
  }
}
