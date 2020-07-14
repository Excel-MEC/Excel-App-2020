import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:excelapp/UI/Screens/LandingPage/landingPage.dart';

Widget introPage() {
  return Column(
    children: <Widget>[
      Text(
        'Welcome',
        style: TextStyle(
            fontSize: 20, color: primaryColor, fontFamily: pfontFamily),
      ),
      SizedBox(height: 40),
      Hero(
        tag: 'logo',
        child: Image.asset(
          'assets/excel logo.png',
          height: 120,
        ),
      ),
      SizedBox(height: 40),
      Text(
        'Excel 2020',
        style: TextStyle(
            fontSize: 25, color: primaryColor, fontFamily: pfontFamily),
      ),
      SizedBox(height: 50),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          "Excel is the annual techno-managerial fest of Govt. Model Engineering College. It is the nations second and south India's first ever of its kind !",
          style: TextStyle(
              fontSize: 15, color: primaryColor, fontFamily: pfontFamily),
        ),
      ),
    ],
  );
}

Widget page(title, desc, img, context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 20),
        Image.asset(
          img,
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 25, color: primaryColor, fontFamily: pfontFamily),
          ),
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: primaryColor, fontFamily: pfontFamily),
          ),
        ),
      ],
    ),
  );
}

Widget lastPage(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Column(
      children: <Widget>[
        SizedBox(height: 10),
        Image.asset(
          'assets/introScreen/page4.jpg',
          height: 180,
        ),
        SizedBox(height: 30),
        Text(
          "Excel 2020",
          style: TextStyle(
              fontSize: 24, color: primaryColor, fontFamily: pfontFamily),
        ),
        SizedBox(height: 10),
        Text(
          "Inspire | Innovate | Engineer",
          style: TextStyle(
              fontSize: 17, color: primaryColor, fontFamily: pfontFamily),
        ),
        SizedBox(height: 30),
        Text(
          "We are as exited as you are !\n Get on the hype train & experience the fest of the year.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, color: primaryColor, fontFamily: pfontFamily),
        ),
        SizedBox(height: 50),
        RaisedButton(
          padding: EdgeInsets.all(15),
          onPressed: () {
            onIntroEnd(context);
          },
          child: Text(
            'Let\'s Get Started',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ],
    ),
  );
}
