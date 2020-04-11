import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Categories/data.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class HighlightsCard extends StatelessWidget {
  final Event event;
  HighlightsCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Image - TODO: Highlights Images
          Container(
            child: CachedNetworkImage(
              imageUrl: categoriesMap[1]['imageUrl'],
              fit: BoxFit.cover,
            ),
          ),
          // Gradient
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [primaryColor, primaryColor],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          // Details
          Container(
            padding: EdgeInsets.fromLTRB(25, 0, 0, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title
                Text(
                  event.name[0].toUpperCase() + event.name.substring(1),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 29,
                  ),
                ),
                SizedBox(height: 5),
                // Date and Time
                Text(
                  // TODO: Fix date and Time
                  event.dateTime != null ? event.dateTime : 'No date | No time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          // On Tap
          Material(
            color: Colors.transparent,
            child: InkWell(
              // TODO: Navigate to event details page
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
