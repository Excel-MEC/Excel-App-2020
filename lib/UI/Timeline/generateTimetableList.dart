import 'package:cached_network_image/cached_network_image.dart';

import '../Home/Utils/constants.dart';
import 'package:flutter/material.dart';

List<Widget> eventList;

class TimeTableList extends StatelessWidget {
  final List<Map<String, String>> eventDetails;

  TimeTableList(this.eventDetails);
  final GlobalKey _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    addEventToList();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(36, 10, 0, 0),
      child: SingleChildScrollView(
        key: _listKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[] + eventList,
        ),
      ),
    );
  }

  addEventToList() {
    eventList = List<Widget>();
    for (int i = 0; i < eventDetails.length; i++) {
      eventList.add(
        Event(eventDetails[i]['content'], eventDetails[i]['name'],
            eventDetails[i]['image']),
      );
    }
  }
}

class Event extends StatefulWidget {
  final String _eventName;
  final String _content;
  final String _imgurl;

  Event(this._content, this._eventName, this._imgurl);
  @override
  EventState createState() =>
      EventState(this._content, this._eventName, this._imgurl);
}

class EventState extends State<Event> {
  final String _eventName;
  final String _content;
  final String _imgurl;

  double circleDiameter = 12;
  double circleTopMargin = 52;

  Size cardSize;
  // GlobalKey _cardKey = GlobalKey();

  EventState(this._content, this._eventName, this._imgurl);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(40, 10, 0, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.zero,
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.zero,
            ),
            color: Colors.deepPurpleAccent[400],
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: CachedNetworkImageProvider(_imgurl), fit: BoxFit.cover),
          ),
          child: Container(
              padding: EdgeInsets.fromLTRB(30, 25, 0, 25),
              decoration: BoxDecoration(
                color: Color(0xdd282849),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.zero,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    _eventName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: pfontFamily,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 19),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _content,
                    style: TextStyle(
                        fontFamily: sfontFamily,
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )),
        ),
        Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              margin: EdgeInsets.only(top: circleTopMargin),
              height: circleDiameter,
              width: circleDiameter,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(30)),
            )),
      ],
    );
  }
}
