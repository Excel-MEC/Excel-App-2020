import 'package:excelapp/UI/Screens/LandingPage/landingPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:excelapp/UI/Components/Navigation/customNavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  leavePage(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime');
    if (firstTime == null || firstTime == true)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    else
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CustomNavigator(),
        ),
      );
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      leavePage(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/excel logo.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
