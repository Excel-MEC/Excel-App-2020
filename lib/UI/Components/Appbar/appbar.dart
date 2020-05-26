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
        fontSize: 19,
        fontWeight: FontWeight.w600,
        fontFamily: pfontFamily
      ),
    ),
    backgroundColor: Colors.white
  );
}
