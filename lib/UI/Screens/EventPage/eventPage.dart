import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventPageBody.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  // TODO: Network connectivity
  Future<EventDetails> fetchEventDetails(String endpoint, int id) async {
    EventDetails result = await EventsAPI.fetchEventDetails(endpoint, id);
    return result;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchEventDetails('events', 1),
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
