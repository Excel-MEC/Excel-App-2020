import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/LoadingUI/alertDialog.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  SafeArea(
                    child: Center(),
                    bottom: false,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      "assets/excel logo.png",
                      width: 120,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Excel 2020",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: primaryColor, fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Insipire  |  Innovate  |  Engineer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 40),
                  DrawerOption(
                    text: "Excel Prelims",
                    icon: Icons.scatter_plot,
                    onPressed: () {
                      alertDialog(text: "Coming Soon", context: context);
                    },
                  ),
                  DrawerOption(
                    text: "Excel Website",
                    icon: Icons.web,
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Color.fromRGBO(19, 145, 188, 1),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff555555), fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
