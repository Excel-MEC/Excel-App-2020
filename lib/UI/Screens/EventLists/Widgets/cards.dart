import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

double cardHeight = 95;
double imgCardWidth = 275;
double sideCardWidth = 75;
Color theme = Color.fromRGBO(15, 10, 70, 1);

Stack cardImage(String url) {
  Color gradientcolor1 = primaryColor;
  Color gradientcolor2 = primaryColor;
  BorderRadius roundness = BorderRadius.circular(16);
  return Stack(children: <Widget>[
    Opacity(
        opacity: 1,
        child: Container(
            //width:imgCardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(url),
                ),
                borderRadius: BorderRadius.all(
                  const Radius.circular(20.0),
                )))),
    //gradient overlay
    Opacity(
        opacity: 0.78,
        child: Container(
          //width: imgCardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
              borderRadius: roundness,
              gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [gradientcolor1, gradientcolor2],
                stops: [0.0, 1.0],
              )),
        ))
  ]);
}

sideCard() {
  Color gradientcolor1 = Colors.grey;
  Color gradientcolor2 = gradientcolor1;
  BorderRadius roundness = BorderRadius.circular(16);
  return Stack(children: <Widget>[
    Opacity(
        opacity: 0.19,
        child: Container(
          width: sideCardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
              borderRadius: roundness,
              gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [gradientcolor1, gradientcolor2],
                stops: [0.0, 1.0],
              )),
        ))
  ]);
}
