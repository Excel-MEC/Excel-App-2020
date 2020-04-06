

// you will get data in this format
// List<Event> highlights
// iterate through list to get Event objects, each event object has fields that can be utilized
// for reference, go to Models > event_card

import 'package:excelapp/Models/event_card.dart';
import 'package:flutter/material.dart';

class Highlights extends StatelessWidget {

  List<Event> highlights;
  Highlights(this.highlights);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}