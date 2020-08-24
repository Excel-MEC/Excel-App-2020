import 'dart:convert';

import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/backgroundImage.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventDescription.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

class MoreDetails extends StatefulWidget {
  final EventDetails eventDetails;
  MoreDetails({Key key, @required this.eventDetails}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MoreDetailsState(eventDetails);
  }
}

class MoreDetailsState extends State<MoreDetails> {
  EventDetails eventDetails;
  MoreDetailsState(this.eventDetails);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          getBackgroundImage(
            [
              Color.fromRGBO(0, 0, 0, 0),
              Color.fromRGBO(23, 18, 41, .8),
              Color.fromRGBO(0, 0, 0, .8),
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromRGBO(255, 255, 255, 1)
            ],
          ),

          Container(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 50.0, top: deviceHeight * 0.15),
                  child: Row(
                    children: <Widget>[
                      //Event Name Details
                      Expanded(
                        child: Hero(
                          tag: 'EventName',
                          child: Text(
                            eventDetails.name,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: pfontFamily,
                              height: 1.0,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //EventDetails
                getEventDetails(eventDetails),

                SizedBox(height: 10.0),

                // More details card
                Container(
                  height: deviceHeight * .65,
                  padding: EdgeInsets.only(top: 5.0),
                  child: Hero(
                    tag: 'Card',
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: DefaultTabController(
                        initialIndex: 0,
                        length: 4,
                        child: Scaffold(
                          appBar: PreferredSize(
                            preferredSize: Size.fromHeight(60),
                            child: AppBar(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              bottom: TabBar(
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: primaryColor,
                                labelColor: primaryColor,
                                labelStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                tabs: [
                                  Tab(
                                    text: 'About',
                                  ),
                                  Tab(
                                    text: 'Format',
                                  ),
                                  Tab(
                                    text: 'Rules',
                                  ),
                                  Tab(
                                    text: 'Contacts',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          body: Container(
                            color: Colors.white,
                            child: TabBarView(
                              children: [
                                details(eventDetails.about),
                                details(eventDetails.format),
                                details(eventDetails.rules),
                                contactDetails(
                                  eventDetails.eventHead1,
                                  eventDetails.eventHead2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget details(txt) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 55),
        child: Text(
          txt ?? "",
          style: TextStyle(
              color: primaryColor, fontSize: 15.0, fontFamily: pfontFamily),
        ),
      ),
    );
  }

  Widget contactDetails(String e1, String e2) {
    Map<String, dynamic> eventHead1 = json.decode(e1);
    Map<String, dynamic> eventHead2 = json.decode(e2);

    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: <Widget>[] +
            (e1 == "null"
                ? []
                : [
                      // Contact 1
                      SizedBox(height: 10),
                      contactDetailRow(Icons.person, eventHead1["name"]),
                      contactDetailRow(Icons.email, eventHead1["email"]),
                      contactDetailRow(Icons.phone, eventHead1["phoneNumber"]),
                    ] +
                    (e2 == "null"
                        ? []
                        : [
                            // Contact 2
                            SizedBox(height: 25),

                            contactDetailRow(Icons.person, eventHead2["name"]),
                            contactDetailRow(Icons.email, eventHead2["email"]),
                            contactDetailRow(
                                Icons.phone, eventHead2["phoneNumber"]),

                            SizedBox(height: 50),
                          ])),
      ),
    ));
  }

  Widget contactDetailRow(var icon, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            size: 17.0,
            color: primaryColor,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              text ?? "",
              style: TextStyle(
                color: primaryColor,
                fontSize: 15.0,
                decoration: TextDecoration.none,
                fontFamily: 'Quicksand-Light',
              ),
            ),
          )
        ],
      ),
    );
  }
}
