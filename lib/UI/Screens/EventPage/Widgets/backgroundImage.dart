import 'package:excelapp/Models/event_details.dart';
import 'package:flutter/material.dart';

Widget getBackgroundImage(EventDetails eventDetails, List<Color> gradient) {
  return Stack(children: <Widget>[

    //Background Image
    Hero(
      tag: 'EventImage',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              // image: NetworkImage(eventDetails.image),
              image: NetworkImage('https://images.unsplash.com/photo-1584918652568-c9ec7152a482?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=669&q=80'),
              fit: BoxFit.cover,),
        ),
      ),
    ),

    //Gradient effect
    Hero(
      tag: 'Gradient',
      child: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient, begin: Alignment.topCenter, end: Alignment.bottomCenter),
      )),
    )
  ]);
}
