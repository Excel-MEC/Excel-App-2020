import 'dart:async';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/constants.dart';
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
  String endpoint;
  StreamController<dynamic> estream;

  @override
  void initState() {
    super.initState();
    endpoint = APIConfig.getEndpoint(widget.category);
    estream = StreamController<dynamic>();
    fetchEvents(endpoint);
  }

  void fetchEvents(String endpoint) async {
    var result1;
    result1 = await EventsAPI.fetchEventListFromStorage(endpoint);
    if (result1 != null) estream.add(result1);

    // If database empty or has been 1 hr since last fetched: Fetch from API
    int lastUpdatedinMinutes =
        await HiveDB().getTimeStamp("eventlist-$endpoint");
    print("$endpoint last fetched $lastUpdatedinMinutes mins ago");
    // If above 60 mins fetch from net
    if (lastUpdatedinMinutes == null ||
        lastUpdatedinMinutes > 60 ||
        result1 == null) {
      var result2 = await EventsAPI.fetchAndStoreEventListFromNet(endpoint);
      if (result2 == "error" && result1 == null) {
        estream.add("error");
        return;
      }
      if (result2 == "error") return;
      HiveDB().setTimeStamp("eventlist-$endpoint");
      print("Fetched & Added to DB");
      estream.add(result2);
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
                if (snapshot.data == "error")
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "An error occured",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          color: primaryColor,
                          padding:
                              EdgeInsets.symmetric(vertical: 9, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Retry",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventsList(endpoint),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                List<Event> list = snapshot.data;
                // If data is present
                if (snapshot.hasData) {
                  // If no events
                  if (list.isEmpty)
                    return Center(
                      child: Text(
                        "No Events",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    );

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
