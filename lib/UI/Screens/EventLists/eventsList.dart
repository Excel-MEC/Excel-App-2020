// A page to display all events
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/UI/Screens/EventLists/Widgets/eventListBuilder.dart';
import 'package:flutter/material.dart';

class EventsList extends StatefulWidget {
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {

  // Fetch events
  Future<List<Event>> fetchEvents(String endpoint) async {
    // TODO: Network connectivity
    List<Event> result = await EventsAPI.fetchEvents(endpoint);
    return result;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: fetchEvents('events'),
        builder: (context,snapshot) {
          if(snapshot.hasData)
            return EventListBuilder(snapshot.data);
          else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}