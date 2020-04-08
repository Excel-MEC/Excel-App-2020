import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/UI/Screens/EventLists/Widgets/listView.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';

class EventsList extends StatefulWidget {
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  // TODO: Network connectivity
  Future<EventDetails> fetchEventDetails(String endpoint,int id) async {
    EventDetails result = await EventsAPI.fetchEventDetails(endpoint, id);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customappbar('Events'),
      body: FutureBuilder(
        future: fetchEventDetails('events',1),
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {}  // return getEventDetails(snapshot.data);
          else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
