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

  @override
  void initState() {
    super.initState();
    endpoint = APIConfig.getEndpoint(widget.category);
    db = DBProvider();
  }

  Future<List<Event>> fetchEvents(String endpoint) async {
    // TODO: Handle handshake errors
    List<Event> result;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      print("\nfetching");
      result = await EventsAPI.fetchEvents(endpoint);
      print("adding to db");
      await db.addEvents(result, 'Competitions');
      print("done");
    } else {
      print("\nfrom db");
      result = await db.getEvents('Competitions');
      print("done");
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
              future: fetchEvents(endpoint),
              builder: (context, snapshot) {
                List<Event> list = snapshot.data;
                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty)
                    // TODO: Proper error UI
                    return Text('Something went wrong');
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EventCard(list[index]);
                    },
                  );
                } else {
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
