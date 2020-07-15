import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

Widget homeAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      'Excel 2020',
      style: TextStyle(
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: pfontFamily),
    ),
    actions: <Widget>[
      Icon(Icons.notifications, color: primaryColor),
      SizedBox(width: 10)
    ],
    iconTheme: IconThemeData(color: primaryColor),
  );
}
