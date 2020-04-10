import 'dart:async';
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
        result == ConnectivityResult.mobile) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // custom appBar widget here
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Highlights
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FutureBuilder(
                  future: EventsAPI.fetchEvents('events'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return HighLights(highLightsMap: snapshot.data);
                    else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              // Categories
              Categories()
            ],
          ),
        ),
      ),
    );
  }
}
