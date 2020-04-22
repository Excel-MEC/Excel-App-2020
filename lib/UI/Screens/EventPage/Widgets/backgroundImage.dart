import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:flutter/material.dart';

Widget getBackgroundImage(EventDetails eventDetails, List<Color> gradient) {
  return Stack(
    children: <Widget>[
      // Background Image
      Hero(
        tag: 'EventImage',
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/BG 2.jpg'),
              // CachedNetworkImageProvider('https://i.ibb.co/10yC5Vs/aaa.jpg'), Light Theme Image
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
      ),
    ],
  );
}
