import 'package:flutter/material.dart';

// Loading UI - Alert Dialog
Widget alertBox(String text) {
  return AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(width: 40.0),
        Text(
          text,
          style: TextStyle(color: Colors.grey),
        )
      ],
    ),
  );
}
