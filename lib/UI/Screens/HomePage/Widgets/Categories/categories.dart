import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import './categoryCard.dart';

class Categories extends StatelessWidget {
  final headingStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    fontFamily: pfontFamily,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(28, 28, 28, 14),
            child: Text(
              "Categories",
              style: headingStyle,
            )),
        categoryCard(0, context),
        categoryCard(1, context),
        categoryCard(2, context),
        categoryCard(3, context),
      ],
    );
  }
}
