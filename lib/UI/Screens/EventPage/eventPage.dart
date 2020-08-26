import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventPageBody.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';

class EventPage extends StatefulWidget {
  final int eventId;
  EventPage(this.eventId);
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DBProvider dbProvider;
  int _eventId;
  String _tableName = "EventDetails";
  StreamController<dynamic> estream;

  @override
  void initState() {
    super.initState();
    _eventId = widget.eventId;
    dbProvider = DBProvider();
    estream = StreamController<dynamic>();
    fetchEventDetails(_eventId);
  }

  void fetchEventDetails(int id) async {
    EventDetails result;
    var connectivityResult = await (Connectivity().checkConnectivity());
    result = await dbProvider.getEventDetails(_tableName, id);
    if (result != null) estream.add(result);

    // No connetions available
    if (connectivityResult == ConnectivityResult.none) {
      print("all connections down");
      if (result == null) estream.add("offline");
      return;
    }

    // If database empty or has been 1 hr since last fetched: Fetch from API
    if (result == null || connectivityResult != ConnectivityResult.none) {
      int lastUpdatedinMinutes = await HiveDB().getTimeStamp("event-$id");
      print("Event $id: last fetched $lastUpdatedinMinutes mins ago");
      // If above 60 mins fetch from net
      if (lastUpdatedinMinutes == null ||
          lastUpdatedinMinutes > 60 ||
          result == null) {
        print("-Fetching from api and updating database: Event $id");
        EventDetails result = await EventsAPI.fetchEventDetails(id);
        if (result == null) return;
        await dbProvider.addEventDetails(result, _tableName);
        HiveDB().setTimeStamp("event-$id");
        print("Fetched & Added to DB");
        estream.add(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: estream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "offline") {
              return Center(
                child: Text(
                  "No Connection. Please retry",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
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
