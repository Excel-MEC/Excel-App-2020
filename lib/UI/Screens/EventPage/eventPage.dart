import 'package:connectivity/connectivity.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventPageBody.dart';

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

  @override
  void initState() {
    super.initState();
    _eventId = widget.eventId;
    dbProvider = DBProvider();
  }

  Future<List<EventDetails>> fetchEventDetails(int id) async {
    List<EventDetails> result;
    var connectivityResult = await (Connectivity().checkConnectivity());
    result = await dbProvider.getEventDetails(_tableName, id);

    // No connetions available
    if (connectivityResult == ConnectivityResult.none) {
      print("all connections down");
      return result;
    }

    // Database empty -- Fetch from API
    if (result.isEmpty && connectivityResult != ConnectivityResult.none) {
      print("\nfetching from api and updating database");
      result.add(await EventsAPI.fetchEventDetails(id));
      await dbProvider.addEventDetails(result[0], _tableName);
      print("done");
      return result;
    }

    // Database not empty -- Update database
    if (result.isNotEmpty && connectivityResult != ConnectivityResult.none) {
      print("Updating database");
      EventsAPI.fetchEventDetails(id).then((value) {
        dbProvider.addEventDetails(result[0], _tableName);
        print("done");
      }).catchError((e) => print("Not Updated : $e"));
      return result;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchEventDetails(_eventId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
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
            return EventPageBody(eventDetails: snapshot.data[0]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
