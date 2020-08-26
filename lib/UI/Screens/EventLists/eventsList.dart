import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/EventCard/event_card.dart';

class EventsList extends StatefulWidget {
  final String category;
  EventsList(this.category);

  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  DBProvider db;
  String endpoint;
  String tableName;
  StreamController<dynamic> estream;

  @override
  void initState() {
    super.initState();
    endpoint = APIConfig.getEndpoint(widget.category);
    tableName = widget.category;
    db = DBProvider();
    estream = StreamController<dynamic>();
    fetchEvents(endpoint);
  }

  void fetchEvents(String endpoint) async {
    List<Event> result;
    var connectivityResult = await (Connectivity().checkConnectivity());
    result = await db.getEvents(tableName);
    if (result.isNotEmpty) estream.add(result);

    // No connetions available
    if (connectivityResult == ConnectivityResult.none) {
      print("all connections down");
      if (result.isEmpty) estream.add("offline");
      return;
    }

    // If database empty or has been 1 hr since last fetched: Fetch from API
    if (result.isEmpty || connectivityResult != ConnectivityResult.none) {
      int lastUpdatedinMinutes =
          await HiveDB().getTimeStamp("eventlist-$endpoint");
      print("$endpoint last fetched $lastUpdatedinMinutes mins ago");
      // If above 60 mins fetch from net
      if (lastUpdatedinMinutes == null ||
          lastUpdatedinMinutes > 60 ||
          result.isEmpty) {
        print("-Fetching from api and updating database: $endpoint");
        result = await EventsAPI.fetchEvents(endpoint);
        if (result == null) return;
        await db.addEvents(result, tableName);
        HiveDB().setTimeStamp("eventlist-$endpoint");
        print("Fetched & Added to DB");
        estream.add(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(widget.category),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: estream.stream,
              builder: (context, snapshot) {
                // If no internet & not stored
                if (snapshot.data == "offline")
                  return Center(
                    child: Text(
                      "You are offline",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  );
                List<Event> list = snapshot.data;
                if (snapshot.hasData) {
                  // If list is empty
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text(
                        "No Events",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EventCard(list[index]);
                    },
                  );
                } else {
                  return LoadingAnimation();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
