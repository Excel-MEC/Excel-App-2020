import 'package:flutter/material.dart';

alertDialog({@required text, @required context}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(text),
        );
      });
}
