import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

Widget homeAppBar() {
  return AppBar(
    leading: Icon(Icons.menu, color: primaryColor),
    backgroundColor: Colors.white,
    elevation: 7,
    title: Text(
      'Excel 2020',
      style: TextStyle(
        color: primaryColor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: <Widget>[
      Icon(Icons.notifications, color: primaryColor),
      SizedBox(width: 10)
    ],
  );
}
