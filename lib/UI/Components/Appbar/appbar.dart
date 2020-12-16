import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

Widget customappbar(String titleText) {
  return AppBar(
    elevation: 4,
    iconTheme: IconThemeData(color: primaryColor),
    backgroundColor: Colors.white,
    title: Text(
      titleText,
      style: TextStyle(
        color: primaryColor,
        fontSize: 17,
      ),
    ),
  );
}
