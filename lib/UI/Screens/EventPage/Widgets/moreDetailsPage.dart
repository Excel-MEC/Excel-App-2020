import 'dart:convert';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/UI/Components/Appbar/darkAppbar.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/backgroundImage.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventDescription.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

class MoreDetails extends StatelessWidget {
  final EventDetails eventDetails;
  MoreDetails({Key key, @required this.eventDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Tab> tabList = [];
    List<Widget> tabContent = [];

// Format & Rules are added only if they are not empty.

// About
    tabList.add(Tab(
      text: 'About',
    ));
    tabContent.add(details(eventDetails.about));

// Format
    if (eventDetails.format != null) {
      tabList.add(Tab(
        text: 'Format',
      ));

      tabContent.add(details(eventDetails.format));
    }

// Rules
    if (eventDetails.rules != null) {
      tabList.add(Tab(
        text: 'Rules',
      ));
      tabContent.add(details(eventDetails.rules));
    }

// Contacts
    tabList.add(Tab(
      text: 'Contacts',
    ));
    tabContent.add(contactDetails(
      eventDetails.eventHead1,
      eventDetails.eventHead2,
    ));

    return Scaffold(
      appBar: darkAppbar(),
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

          Column(
            children: <Widget>[
              SafeArea(bottom: false, child: Container()),
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 30),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    // Event Name Details
                    Expanded(
                      child: Hero(
                        tag: 'EventName',
                        child: Text(
                          eventDetails.name,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: pfontFamily,
                            height: 1.0,
                            fontSize: 23.0,
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
              getEventDetails(eventDetails: eventDetails, detailed: false),

              SizedBox(height: 7.0),

              // More details card
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  child: DefaultTabController(
                    initialIndex: 0,
                    length: tabList.length,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(1000),
                        child: TabBar(
                          labelPadding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                          indicatorColor: primaryColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: primaryColor,
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: tabList,
                        ),
                      ),
                      body: Container(
                        color: Colors.white,
                        child: TabBarView(
                          children: tabContent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget details(txt) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 100),
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
