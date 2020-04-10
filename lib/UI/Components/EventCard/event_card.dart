import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/Components/LikeButton/likeButton.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(event.icon),
              ),
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
            padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
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
                    fontSize: 27,
                  ),
                ),
                SizedBox(height: 5),
                // Date and Time
                Text(
                  event.dateTime != null ? event.dateTime : 'No date | No time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
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
          // Favourites
          Positioned(
            right: 25,
            bottom: 25,
            child: LikeButton(false),
          )
        ],
      ),
    );
  }
}
