import 'dart:convert';

import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/API/campus_ambassador.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/AmbassadorPage/referedUsers.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class AmbassadorPage extends StatefulWidget {
  final User userData;
  AmbassadorPage(this.userData);
  @override
  _AmbassadorPageState createState() => _AmbassadorPageState();
}

class _AmbassadorPageState extends State<AmbassadorPage> {
  User userData;
  Future referalList;
  Map<String, dynamic> ambassadorData;

  @override
  void initState() {
    userData = widget.userData;
    ambassadorData = jsonDecode(userData.ambassador);
    referalList = getReferalList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/campusAmbassador/refer.png", height: 150),
            SizedBox(height: 20),
            Text(
              "Hello " + userData.name.split(" ")[0] + ",",
              style: TextStyle(fontSize: 23, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Share this code to other users\n to add them as referals",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xaa000000)),
            ),
            SizedBox(height: 5),
            // Row with referal code
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.grey,
                      spreadRadius: -5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 30),
                    Text(
                      ambassadorData["id"].toString(),
                      style: TextStyle(fontSize: 30, color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.content_copy,
                        size: 25,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        print("object");
                      },
                    )
                  ],
                ),
              ),
            ),

            // Refered users section
            FutureBuilder(
              future: referalList,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Column(
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                if (snapshot.data == "error") return referalError();
                return ReferedUsers(referedUsers: snapshot.data);
              },
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  Widget referalError() {
    return Center(
      child: Column(
        children: [
          Text(
            "An Error Occured",
            style: TextStyle(
              color: Color(0xaa000000),
            ),
          ),
          SizedBox(height: 20),
          RaisedButton(
            color: primaryColor,
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AmbassadorPage(userData),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
