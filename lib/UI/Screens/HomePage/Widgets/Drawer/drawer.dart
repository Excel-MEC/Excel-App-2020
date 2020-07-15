import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SafeArea(
                  child: Center(),
                  bottom: false,
                ),
                SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    "assets/excel logo.png",
                    height: 110,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Excel 2020",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 21,
                    fontFamily: pfontFamily,
                  ),
                ),
                Center(
                  child: Container(
                    color: Color(0x22000000),
                    height: 1,
                    width: 100,
                    margin: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                Text(
                  "Insipire  |  Innovate  |  Engineer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontFamily: pfontFamily,
                  ),
                ),
                Center(
                  child: Container(
                    color: Color(0x22000000),
                    height: 1,
                    width: 100,
                    margin: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                SizedBox(height: 10),
                DrawerOption(
                  text: "Excel Prelims",
                  icon: Icons.short_text,
                  onPressed: () {
                    alertDialog(text: "Coming Soon", context: context);
                  },
                ),
                DrawerOption(
                  text: "Excel Website",
                  icon: Icons.dvr,
                  onPressed: () {
                    launch("https://excelmec.org/");
                  },
                ),
                DrawerOption(
                  text: "Share",
                  icon: Icons.share,
                  onPressed: () {
                    alertDialog(text: "Coming Soon", context: context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 100)
        ],
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  final Function onPressed;
  final String text;
  final IconData icon;
  DrawerOption({this.text, this.onPressed, this.icon});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: primaryColor,
              size: 17,
            ),
            SizedBox(width: 13),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xaa000000),
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

launchURL(url) async {
  if (await canLaunch(url) && url != '') {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}