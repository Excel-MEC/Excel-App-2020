import 'package:flutter/material.dart';

dialogWithContent({@required Widget child, @required context}) {
  showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: child,
        );
      });
}
