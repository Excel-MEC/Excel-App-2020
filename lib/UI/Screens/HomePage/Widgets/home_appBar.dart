import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

Widget homeAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(65.0),
    child: AppBar(
      leading: Icon(Icons.menu, color: primaryColor),
      backgroundColor: Colors.white,
      elevation: 1,
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
    ),
  );
}
