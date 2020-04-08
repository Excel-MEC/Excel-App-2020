import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_details.dart';

Widget getEventDetails(EventDetails eventDetails, var _minpadding) {
  return Hero(
    tag: 'EventDescription',
    child: Padding(
        padding: EdgeInsets.only(left: _minpadding * 8, top: _minpadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              //Event Time Details
              children: <Widget>[
                Icon(
                  Icons.calendar_today,
                  size: 15.0,
                  color: Colors.white,
                ),
                Container(padding: EdgeInsets.only(right: _minpadding * 2)),
                eventDescriptionText(eventDetails.dateTime)
              ],
            ),
            Container(padding: EdgeInsets.only(top: _minpadding * 2)),

            //Event Venue Details
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.add_location,
                  size: 15.0,
                  color: Colors.white,
                ),
                Container(padding: EdgeInsets.only(right: _minpadding * 2)),
                eventDescriptionText(eventDetails.venue)
              ],
            ),
            Container(padding: EdgeInsets.only(top: _minpadding * 2)),

            //EventContacts
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.phone,
                  size: 15.0,
                  color: Colors.white,
                ),
                Padding(padding: EdgeInsets.only(right: _minpadding * 2)),
                eventDescriptionText(
                    eventDetails.contacts[0]['phone_number'].toString())
              ],
            ),
            Container(padding: EdgeInsets.only(top: _minpadding * 2)),

            //Event Fee Details
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.label,
                  size: 15.0,
                  color: Colors.white,
                ),
                Container(padding: EdgeInsets.only(right: _minpadding * 2)),
                eventDescriptionText(eventDetails.category)
              ],
            ),
          ],
        )),
  );
}

//Event Description's text styling
Widget eventDescriptionText(String text) {
  return Expanded(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        decoration: TextDecoration.none,
        fontFamily: 'Quicksand-Light',
        fontWeight: FontWeight.w300,
      ),
    ),
  );
}
