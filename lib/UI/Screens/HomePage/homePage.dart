import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Categories/categories.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Highlights/highlights.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Future<List<Event>> fetchHighlights() async {
    // TODO: network connectivity
    List<Event> highlights = await EventsAPI.fetchEvents('events');
    return highlights;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // custom appBar widget here
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[

            //  Highlights
            FutureBuilder(
              future: fetchHighlights(),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return HighLights(highLightsMap: snapshot.data);
                else
                  return CircularProgressIndicator();
              },
            ),

            // Categories -- do not add any code here, Categories() widget should display all categories
            // Categories()
          ],
        ),
      ),
    );
  }
}
