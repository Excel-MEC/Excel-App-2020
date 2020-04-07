import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/events_api.dart';
import './Widgets/listView.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';

class EventsList extends StatefulWidget {
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  // Fetch events
  Future<List<Event>> fetchEvents(String endpoint) async {
    List<Event> result = await EventsAPI.fetchEvents(endpoint);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Events'),
      body: FutureBuilder(
        future: fetchEvents('events'),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return getListView(snapshot.data);
          else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
