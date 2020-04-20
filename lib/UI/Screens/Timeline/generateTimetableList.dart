import 'package:cached_network_image/cached_network_image.dart';

import '../../constants.dart';
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
      children: <Widget>[Padding(padding: EdgeInsets.all(8))] + eventList,
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
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.fromLTRB(13, 7, 5, 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.zero,
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.zero,
              ),
              // border: Border.all(width: .5, color: Color(0xffbbbbbb)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                  spreadRadius: -0.2,
                  offset: Offset(-0.4, 0.4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: 45.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(_imgurl)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.transparent,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        _eventName,
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 15,
                            fontFamily: pfontFamily),
                      ),
                      SizedBox(height: 5),
                      iconAndText(Icons.place, _venue),
                      iconAndText(Icons.timer, _time),
                    ],
                  ),
                ),
              ],
            ),
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
  double rowHeight = 90.0;
  return Stack(
    children: <Widget>[
      Container(
        width: 45,
      ),
      Container(
        margin: lineNumber != 0
            ? (lineNumber == noOfEvents
                ? EdgeInsets.only(left: 22.5, bottom: rowHeight / 2)
                : EdgeInsets.only(left: 22.5))
            : EdgeInsets.only(left: 22.5, top: rowHeight / 2),
        width: 1.0,
        height: lineNumber != 0
            ? lineNumber==noOfEvents?rowHeight/2: rowHeight
            : rowHeight / 2,
        color: Color(0xff777777),
      ),
      Container(
        margin: EdgeInsets.only(left: 19, top: 38),
        child: CircleAvatar(
          backgroundColor: lineNumber % 2 == 0 ? Colors.blue : Colors.red,
          radius: 4,
        ),
      )
    ],
  );
}
