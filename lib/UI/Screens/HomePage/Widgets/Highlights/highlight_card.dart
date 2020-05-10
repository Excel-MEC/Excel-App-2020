import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/highlights_model.dart';
import 'package:flutter/material.dart';

class HighlightsCard extends StatelessWidget {
  final Highlights highlights;
  HighlightsCard(this.highlights);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: CachedNetworkImage(
              imageUrl: highlights.image,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
