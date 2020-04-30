import 'package:connectivity/connectivity.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/Services/Database/Tables/events_table.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventPageBody.dart';

class EventPage extends StatefulWidget {
  final String endpoint;
  final int eventId;
  EventPage(this.endpoint, this.eventId);
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DBProvider dbProvider;
  String _endpoint;
  int _eventId;
  String _tableName;

  @override
  void initState() {
    super.initState();
    _endpoint = widget.endpoint;
    _eventId = widget.eventId;
    // To get details-table name from endpoint
    _tableName = DBEventsTable.tableName(widget.endpoint);
    dbProvider = DBProvider();
  }

  // TODO: Network connectivity
  Future<EventDetails> fetchEventDetails(String endpoint, int id) async {
    EventDetails result;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
          print("Fetching details");
          result = await EventsAPI.fetchEventDetails(endpoint, id);
          print("adding to $_tableName table");
          await dbProvider.addEventDetails(result, _tableName);
          print("done");
        } else {
          print("from $_tableName table");
          result = await dbProvider.getEventDetails(_tableName, _eventId);
          print("done");
        }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchEventDetails(_endpoint, _eventId),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return EventPageBody(eventDetails: snapshot.data);
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
