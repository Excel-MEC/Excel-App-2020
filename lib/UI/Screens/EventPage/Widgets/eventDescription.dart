import 'package:excelapp/Models/event_card.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/UI/constants.dart';

Widget getEventDetails(EventDetails eventDetails) {
  return Hero(
    tag: 'EventDescription',
    child: Padding(
      padding: EdgeInsets.only(left: 50, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Date and Time
          detailRow(
              Icons.data_usage,
              DateTimeConversion.dateTimeToString(
                  eventDetails.datetime.toString())),
          SizedBox(height: 7.0),
          // Prize money
          detailRow(
              Icons.attach_money,
              eventDetails.prizeMoney == null
                  ? "N.A"
                  : "Rs " + eventDetails.prizeMoney.toString()),
          SizedBox(height: 7.0),
          // Team or not
          detailRow(
              Icons.people_outline,
              eventDetails.isTeam == 1
                  ? "Team size: " +
                      (eventDetails.teamSize ?? "Not Specified").toString()
                  : 'Induvidual Event'),
          SizedBox(height: 7.0),
          // Venue
          detailRow(Icons.location_on, eventDetails.venue.toString()),
          SizedBox(height: 7.0),
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
            fontSize: 14.5,
            fontFamily: pfontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ],
  );
}
