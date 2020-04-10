import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: MediaQuery.of(context).size.height / 5,
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
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [primaryColor,primaryColor],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          // Details
        ],
      ),
    );
  }
}
