// import files as packages -- shown below
import 'package:excelapp/UI/Screens/HomePage/homePage.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel 2020',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        // '/': (BuildContext context) => MyHomePage(),
      },
    );
  }
}
