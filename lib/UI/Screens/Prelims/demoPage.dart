import 'package:excelapp/UI/Screens/Prelims/PreTestPage/preTestPage.dart';
import 'package:excelapp/UI/Screens/Prelims/TestPage/testPage.dart';
import 'package:excelapp/UI/Screens/Prelims/TetstsList/listOfTests.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UI of other Pages'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 30),
              // Links to pages
              RaisedButton(
                  child: Text('Test Page'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TestPage()));
                  }),
              RaisedButton(
                  child: Text('Page Before Test'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PreTestPage()));
                  }),
              RaisedButton(
                  child: Text('Page with list of all Tests'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListOfTests()));
                  }),
            ],
          ),
        ));
  }
}
