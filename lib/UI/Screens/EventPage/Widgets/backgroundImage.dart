import 'package:excelapp/Models/event_details.dart';
import 'package:flutter/material.dart';

Widget getBackgroundImage(EventDetails eventDetails, List<Color> gradient) {
  return Stack(
    children: <Widget>[
      //Background Image
      Hero(
        tag: 'EventImage',
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              // image: NetworkImage(eventDetails.image),
              image: AssetImage('assets/BG 2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      //Gradient effect
      Hero(
        tag: 'Gradient',
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      )
    ],
  );
}
