import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/highlights.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/categories.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          homeTitle(context),
          Container(height: 100),
          Padding(padding: EdgeInsets.only(bottom: 16)),
          HighLights(),
          Categories()
        ],
      ),
    );
  }

  homeTitle(BuildContext context) {
    double fontSize = 28;
    var fontWeight = FontWeight.w700;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Excel 2020",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: primaryColor,
                fontFamily: pfontFamily,
              )),
          headingIcons(context)
        ],
      ),
    );
  }

  headingIcons(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.person_outline),
          iconSize: 30,
          color: primaryColor,
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications_none),
          iconSize: 28,
          color: primaryColor,
          onPressed: () {},
        )
      ],
    );
  }

  customAppBar() {
    return PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(0));
  }
}


