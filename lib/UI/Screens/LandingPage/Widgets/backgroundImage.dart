import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget backgroundImage() {
  String backgroundImageURL =
      "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80";

  //for gradient overlay
  Color color1 = Color(0x4d09122b);
  Color color2 = Color(0x80111e42);

  return Stack(
    children: <Widget>[
      Container(
        height: screenSize.height,
        child: CachedNetworkImage(
          imageUrl: backgroundImageURL,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        ),
      ),
      Opacity(
        opacity: 0.8,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
              colors: [color1, color2],
              stops: [0.0, 1.0],
            ),
          ),
        ),
      )
    ],
  );
}
