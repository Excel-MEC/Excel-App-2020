import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileTheme {
  static var bgColor = Colors.grey[200];
  static double imageHeight = 160;
  static var headingStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: pfontFamily,
    fontSize: 22.0,
    color: primaryColor,
  );
  static var nameStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: pfontFamily,
    fontSize: 24.0,
    color: primaryColor,
  );
  static var buttonTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: pfontFamily,
    fontWeight: FontWeight.w600,
  );
  static var detailsTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
