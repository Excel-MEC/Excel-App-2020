import 'dart:async';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/UI/Components/Appbar/darkAppbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventPageBody.dart';

class EventPage extends StatefulWidget {
  final int eventId;
  EventPage(this.eventId);
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _eventId;
  StreamController<dynamic> estream;

  @override
  void initState() {
    super.initState();
    _eventId = widget.eventId;
    estream = StreamController<dynamic>();
    fetchEventDetails(_eventId);
  }

  void fetchEventDetails(int id) async {
    var result1;
    result1 = await EventsAPI.fetchEventDetailsFromStorage(id);
    if (result1 != null) estream.add(result1);
    // Fetch from net & update
    var result2 = await EventsAPI.fetchAndStoreEventDetailsFromNet(id);
    if (result2 == "error" && result1 == null) {
      estream.add("error");
      return;
    }
    if (result2 == "error") return;
    print("$id fetched, added to DB & updated in UI");
    estream.add(result2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: darkAppbar(),
      body: StreamBuilder(
        stream: estream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "error") {
              return Center(
                child: Text(
                  "Failed to load event. Please retry",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return EventPageBody(eventDetails: snapshot.data);
          } else {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //Background Image
                getBackgroundImage(
                  [
                    Color.fromRGBO(0, 0, 0, 0),
                    Color.fromRGBO(23, 18, 41, .8),
                    Color.fromRGBO(0, 0, 0, .8)
                  ],
                ),
                LoadingAnimation(color: Colors.white)
              ],
            );
          }
        },
      ),
    );
  }
}
