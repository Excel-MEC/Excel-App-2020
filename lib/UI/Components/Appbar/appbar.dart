import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

Widget customappbar(String titleText) {
  return AppBar(
      elevation: 2,
      title: Row(
        children: <Widget>[
          Text(titleText,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 23,
                  fontWeight: FontWeight.bold)),
          Expanded(child: SizedBox()),
          IconButton(
              icon: Icon(Icons.search),
              color: primaryColor,
              onPressed: () {/*...*/})
        ],
      ),
      backgroundColor: Colors.white);
}
