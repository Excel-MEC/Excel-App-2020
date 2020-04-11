import 'package:excelapp/UI/Screens/HomePage/Widgets/Categories/data.dart';
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
          padding: EdgeInsets.fromLTRB(28, 28, 28, 15),
          child: Text(
            "Categories",
            style: headingStyle,
          ),
        ),
        CategoryCard(categoriesMap[0]),
        CategoryCard(categoriesMap[1]),
        CategoryCard(categoriesMap[2]),
        CategoryCard(categoriesMap[3]),

        // Extras
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Excel 2020"),
                Text("All rights reserved"),
              ],
            ),
          ),
        )
      ],
    );
  }
}
