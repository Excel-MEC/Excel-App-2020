import 'dart:async';
import 'package:excelapp/UI/Screens/HomePage/Widgets/home_appBar.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Categories/categories.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Highlights/highlights.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/socialIcons.dart';

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
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Text(
                        "Highlights",
                        style: headingStyle,
                      ),
                    ),
                    FutureBuilder(
                      future: EventsAPI.fetchHighlights(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return HighLights(highLightsMap: snapshot.data);
                        else {
                          return Container(
                            child: Shimmer.fromColors(
                              child: Container(
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height/4,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              // Categories
              Categories(),
              socialMediaIcons(),
              SizedBox(height: MediaQuery.of(context).size.height / 6)
            ],
          ),
        ),
      ),
    );
  }
}
