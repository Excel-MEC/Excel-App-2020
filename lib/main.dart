import 'package:excelapp/UI/Screens/HomePage/homePage.dart';
import 'package:excelapp/UI/Screens/LandingPage/landingPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Excel 2020',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
      routes: {
        // '/': (BuildContext context) => MyHomePage(),
      },
    );
  }
}
