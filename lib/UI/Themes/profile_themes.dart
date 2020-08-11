import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileTheme {
  static var bgColor = Colors.grey[200];
  static double imageHeight = 160;
  static var headingStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22.0,
    color: primaryColor,
  );
  static var nameStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: primaryColor,
  );
  static var buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static var detailsTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}
