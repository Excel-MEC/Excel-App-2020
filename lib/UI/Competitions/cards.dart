import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

double cardHeight = 95;
double imgCardWidth = 275;
double sideCardWidth = 75;
Color theme = Color.fromRGBO(15, 10, 70, 1);

Stack cardImage(String url) {
  Color gradientcolor1 = theme; // Color(0xe61f1a59);
  Color gradientcolor2 = theme;
  // var gradientcolor1 = Color(0xe61f1a59);
  // var gradientcolor2 = Color(0x801f1a59);
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
                  image: CachedNetworkImageProvider(url),
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
