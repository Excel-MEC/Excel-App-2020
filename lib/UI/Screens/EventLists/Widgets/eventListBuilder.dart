import 'package:excelapp/Models/event_card.dart';
import 'package:flutter/material.dart';

// this stateless widget takes input of the form
// List<Event>
// returns a ListViewBuilder with the event cards

class EventListBuilder extends StatelessWidget {
  List<Event> eventsList;
  EventListBuilder(this.eventsList);

  // use the eventsList below
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}