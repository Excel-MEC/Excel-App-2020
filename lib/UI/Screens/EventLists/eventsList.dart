import 'package:connectivity/connectivity.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
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
  Future<List<Event>> eventList;

  @override
  void initState() {
    super.initState();
    endpoint = APIConfig.getEndpoint(widget.category);
    tableName = widget.category;
    db = DBProvider();
    eventList = fetchEvents(endpoint);
  }

  Future<List<Event>> fetchEvents(String endpoint) async {
    List<Event> result;
    var connectivityResult = await (Connectivity().checkConnectivity());
    result = await db.getEvents(tableName);

    // No connetions available
    if (connectivityResult == ConnectivityResult.none) {
      print("all connections down");
      return result;
    }

    // Database empty -- Fetch from API
    if (result.isEmpty && connectivityResult != ConnectivityResult.none) {
      print("\nFetching from api and updating database:Event List");
      result = await EventsAPI.fetchEvents(endpoint);
      await db.addEvents(result, tableName);
      print("done");
      return result;
    }

    // Database not empty -- Update database
    if (result.isNotEmpty && connectivityResult != ConnectivityResult.none) {
      print("Updating database: Event List");
      EventsAPI.fetchEvents(endpoint).then((value) {
        db.addEvents(value, tableName);
        print("done");
      }).catchError((e) => print("Not Updated : $e"));
      return result;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(widget.category),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: eventList,
              builder: (context, snapshot) {
                List<Event> list = snapshot.data;
                if (snapshot.hasData) {
                  // If no data is obtained from API
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
                  // TODO : Proper load UI
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
