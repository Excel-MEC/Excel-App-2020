// Entry file to home page
// only add widgets here !!!
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // custom appBar widget here
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
           
          //  Stories widget goes here

          // Highlights carousel widget goes here

          // List of cards goes here -- Competitions,Events,Talks,Workshops

          ],
        ),
      ),
    );
  }
}
