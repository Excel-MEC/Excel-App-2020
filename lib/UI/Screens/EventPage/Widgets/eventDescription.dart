import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_details.dart';

Widget getEventDetails(EventDetails eventDetails, var _minpadding) {
  return Hero(
    tag: 'EventDescription',
    child: Padding(
      padding: EdgeInsets.only(left: _minpadding * 10, top: _minpadding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          
          // Date and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.calendar_today,
                size: 20.0,
                color: Colors.white,
              ),
              SizedBox(width: _minpadding * 2),
              eventDescriptionText(eventDetails.dateTime)
            ],
          ),
          SizedBox(height: _minpadding * 2),

          // Venue
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.add_location,
                size: 20.0,
                color: Colors.white,
              ),
              SizedBox(width: _minpadding * 2),
              eventDescriptionText(eventDetails.venue)
            ],
          ),
          SizedBox(height: _minpadding * 2),

          // Contacts
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.phone,
                size: 20.0,
                color: Colors.white,
              ),
              SizedBox(width: _minpadding * 2),
              eventDescriptionText(
                  eventDetails.contacts[0]['phone_number'].toString())
            ],
          ),
          SizedBox(height: _minpadding * 2),

          // TODO: Prize money
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.label,
                size: 20.0,
                color: Colors.white,
              ),
              SizedBox(width: _minpadding * 2),
              eventDescriptionText(eventDetails.category)
            ],
          ),
        ],
      ),
    ),
  );
}

//Event Description's text styling
Widget eventDescriptionText(String text) {
  return Expanded(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17.0,
        fontFamily: 'Quicksand-Light',
        fontWeight: FontWeight.w300,
      ),
    ),
  );
}
