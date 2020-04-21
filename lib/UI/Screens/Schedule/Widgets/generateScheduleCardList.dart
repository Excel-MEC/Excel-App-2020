import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

List<Widget> eventList;

class TimeTableList extends StatelessWidget {
  final List<Map<String, String>> eventDetails;

  TimeTableList(this.eventDetails);
  final GlobalKey _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    addEventToList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[Padding(padding: EdgeInsets.all(8))] +
          eventList +
          [
            SizedBox(
              height: 90,
            )
          ],
    );
  }

  addEventToList() {
    eventList = List<Widget>();
    for (int i = 0; i < eventDetails.length; i++) {
      eventList.add(
        Event(
            eventDetails[i]['name'],
            eventDetails[i]['venue'],
            eventDetails[i]['time'],
            eventDetails[i]['image'],
            i,
            eventDetails.length),
      );
    }
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

  Size cardSize;
  // GlobalKey _cardKey = GlobalKey();

  EventState(this._eventName, this._venue, this._time, this._imgurl,
      this.lineNumber, this.eventLength);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        lineAndDot(lineNumber, eventLength),
        Expanded(
          child: Card(
            elevation: 2,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 7, 5, 7),
                child: ListTile(
                  title: Text(_eventName),
                  leading: CachedNetworkImage(
                    imageUrl: _imgurl,
                    width: 40,
                    height: 40,
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      iconAndText(Icons.place, _venue),
                      iconAndText(Icons.timer, _time)
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

Widget iconAndText(var icon, String text) {
  var primaryColor = Color(0xff666688);
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 10),
      Icon(
        icon,
        size: 13.0,
        color: primaryColor,
      ),
      SizedBox(width: 5),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
              color: primaryColor,
              fontSize: 11.0,
              decoration: TextDecoration.none,
              fontFamily: pfontFamily),
        ),
      )
    ],
  );
}

Widget lineAndDot(lineNumber, noOfEvents) {
  noOfEvents = noOfEvents - 1;
  double rowHeight = 93.0;
  double left=23.0;
  double circleRadius=4.2;
  return Stack(
    children: <Widget>[
      Container(
        width: 45,
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
        color: Color(0xff777777),
      ),
      Container(
        margin: EdgeInsets.only(left: 19, top: 38),
        child: CircleAvatar(
          backgroundColor: lineNumber % 2 == 0 ? Colors.cyan : Colors.red,
          radius: circleRadius,
        ),
      )
    ],
  );
}
