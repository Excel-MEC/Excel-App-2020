import 'package:connectivity/connectivity.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
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
  DBProvider db;
  String endpoint;

  @override
  void initState() {
    super.initState();
    db = DBProvider();
    endpoint = APIConfig.getEndpoint(widget.category);
  }

  Future<List<Event>> fetchEvents(String endpoint) async {
    List<Event> result;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      result = await EventsAPI.fetchEvents(endpoint);
      await db.addEvents(result, 'Competitions');
    } else {
      result = await db.getEvents('Competitions');
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(widget.category),
      body: FutureBuilder(
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
                return TestCard(list[index]);
              },
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
