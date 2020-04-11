import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class HighlightsCard extends StatelessWidget {
  final Event event;
  HighlightsCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: MediaQuery.of(context).size.height / 5.5,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Image
          Container(
            child: CachedNetworkImage(
              imageUrl: event.icon,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient
          Opacity(
            opacity: 0.8,
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
          // Favourites - Add below if required (Use Positioned)
        ],
      ),
    );
  }
}
