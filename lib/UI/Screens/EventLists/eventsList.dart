import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/EventCard/event_card.dart';


class EventsList extends StatefulWidget {
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  // TODO: Network connectivity
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
          List<Event> list = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context,int index) {
                return EventCard(list[index]);
              },
            );
          }
          else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
