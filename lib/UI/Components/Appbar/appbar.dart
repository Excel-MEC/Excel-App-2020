import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

Widget customappbar(String titleText) {
  return AppBar(
    elevation: 4,
    iconTheme: IconThemeData(color: primaryColor),
    title: Text(
      titleText,
      style: TextStyle(
        color: primaryColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.white
  );
}
