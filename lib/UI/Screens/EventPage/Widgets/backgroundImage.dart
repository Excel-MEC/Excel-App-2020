import 'package:flutter/material.dart';

Widget getBackgroundImage(List<Color> gradient) {
  return Stack(
    children: <Widget>[
      // Background Image
      Hero(
        tag: 'EventImage',
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
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
      ),
    ],
  );
}
