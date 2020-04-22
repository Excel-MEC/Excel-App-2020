import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/UI/constants.dart';

Widget getEventDetails(EventDetails eventDetails) {
  return Hero(
    tag: 'EventDescription',
    child: Padding(
      padding: EdgeInsets.only(left: 50, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Date and Time
          detailRow(Icons.calendar_today, eventDetails.dateTime),
          SizedBox(height: 10.0),
          // Venue
          detailRow(Icons.add_location, eventDetails.venue),
          SizedBox(height: 10.0),
          // Prize money
          detailRow(Icons.attach_money, eventDetails.prize + ' Rs'),
        ],
      ),
    ),
  );
}

Widget detailRow(IconData icon, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Icon(
        icon,
        size: 20.0,
        color: Colors.white,
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontFamily: pfontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      )
    ],
  );
}
