import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

Widget snackBar(String txt) {
  return SnackBar(
    content: Text(txt,style: TextStyle(color: Colors.white)),
    backgroundColor: primaryColor,
    duration: Duration(seconds: 2),
  );
}