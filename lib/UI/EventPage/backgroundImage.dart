import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget getBackgroundImage(var eventDetails, List<Color> gradient) {
  return Stack(children: <Widget>[

    //Background Image
    Hero(
      tag: 'EventImage',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(eventDetails['ImageDir']),
              fit: BoxFit.cover),
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
