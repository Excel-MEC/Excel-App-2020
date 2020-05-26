import 'package:excelapp/UI/Screens/HomePage/Widgets/Categories/data.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import './categoryCard.dart';

final headingStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 24,
  fontFamily: pfontFamily,
  color: Colors.black87,
);

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Heading
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Text(
            "Categories",
            style: headingStyle,
          ),
        ),

        // Categories
        CategoryCard(categoriesMap[0]),
        CategoryCard(categoriesMap[1]),
        CategoryCard(categoriesMap[2]),
        CategoryCard(categoriesMap[3]),
        CategoryCard(categoriesMap[4]),

        // Extras
        Container(
          height: MediaQuery.of(context).size.height / 4,
        )
      ],
    );
  }
}
