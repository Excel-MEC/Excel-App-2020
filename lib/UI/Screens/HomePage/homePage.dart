import 'dart:async';
import 'package:excelapp/UI/Screens/HomePage/Widgets/home_appBar.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Categories/categories.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Highlights/highlights.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = Connectivity();
    subscription = connectivity.onConnectivityChanged.listen(_onChange);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // Method invoked when connection changes
  _onChange(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile)
      setState(() {});
    else
      print("no Internet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Highlights
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Text(
                      "Highlights",
                      style: headingStyle,
                    ),
                  ),
                  FutureBuilder(
                    // TODO: provide highlights API when ready
                    future: EventsAPI.fetchEvents('events'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return HighLights(highLightsMap: snapshot.data);
                      else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              )),
              // Categories
              Categories(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
