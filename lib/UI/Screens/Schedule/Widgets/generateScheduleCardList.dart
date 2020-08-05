import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class TimeTableList extends StatelessWidget {
  final eventDetails;

  TimeTableList(this.eventDetails);

  @override
  Widget build(BuildContext context) {
    print(eventDetails);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[Padding(padding: EdgeInsets.all(8))] +
          List.generate(
            eventDetails.length,
            (i) => Event(
                eventDetails[i]['name'],
                eventDetails[i]['round'],
                eventDetails[i]['datetime'],
                eventDetails[i]['icon'],
                i,
                eventDetails.length),
          ) +
          [
            SizedBox(
              height: 90,
            )
          ],
    );
  }
}

class Event extends StatefulWidget {
  final String _eventName;
  final String _venue;
  final String _time;
  final String _imgurl;
  final int lineNumber;
  final int eventLength;

  Event(this._eventName, this._venue, this._time, this._imgurl, this.lineNumber,
      this.eventLength);
  @override
  EventState createState() => EventState(this._eventName, this._venue,
      this._time, this._imgurl, this.lineNumber, this.eventLength);
}

class EventState extends State<Event> {
  final String _eventName;
  final String _venue;
  final String _time;
  final String _imgurl;
  final int lineNumber;
  final int eventLength;

  EventState(this._eventName, this._venue, this._time, this._imgurl,
      this.lineNumber, this.eventLength);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        lineAndDot(lineNumber, eventLength),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: ListTile(
              dense: true,
              title: Text(
                _eventName,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: CachedNetworkImage(
                imageUrl: _imgurl,
                width: 40,
                height: 40,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_time),
                  SizedBox(height: 3),
                  Text(_venue),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget lineAndDot(lineNumber, noOfEvents) {
  noOfEvents = noOfEvents - 1;
  double rowHeight = 95.0;
  double left = 25;
  double circleRadius = 4.5;
  double width = left * 2 - 10;
  return Stack(
    children: <Widget>[
      Container(
        width: width,
      ),
      Container(
        margin: lineNumber != 0
            ? (lineNumber == noOfEvents
                ? EdgeInsets.only(left: left, bottom: rowHeight / 2)
                : EdgeInsets.only(left: left))
            : EdgeInsets.only(left: left, top: rowHeight / 2),
        width: 1.0,
        height: lineNumber != 0
            ? lineNumber == noOfEvents ? rowHeight / 2 : rowHeight
            : rowHeight / 2,
        color: primaryColor,
      ),
      Container(
        margin: EdgeInsets.only(left: left - circleRadius, top: 38),
        child: CircleAvatar(
          backgroundColor: primaryColor,
          radius: circleRadius,
        ),
      )
    ],
  );
}
