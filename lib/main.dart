import 'package:flutter/material.dart';
import './UI/Home/home.dart';


void main() => runApp(MyApp());


// Import Pages to Navigation/pageNavigator.dart and assign them to tabs

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel 2020',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        // '/': (BuildContext context) => MyHomePage(),
      },
    );
  }
}
