import 'package:flutter/material.dart';

alertDialog({@required text, @required context}) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(text),
      );
    },
  );
}
