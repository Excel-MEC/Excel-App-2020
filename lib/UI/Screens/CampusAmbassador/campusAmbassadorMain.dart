import 'package:excelapp/Services/API/campus_ambassador.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/AmbassadorPage/ambassadorPage.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/joinProgram.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class CampusAmbassador extends StatefulWidget {
  @override
  _CampusAmbassadorState createState() => _CampusAmbassadorState();
}

class _CampusAmbassadorState extends State<CampusAmbassador> {
  var ambassadorDetails;

  @override
  void initState() {
    ambassadorDetails = fetchAmbassadorDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Campus Ambassador"),
      body: FutureBuilder(
        future: ambassadorDetails,
        builder: (context, snapshot) {
          // If no Data
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          // If not logged in
          if (snapshot.data == "notLoggedIn") return Text("Not logged in");
          // If error
          if (snapshot.data == "error") return errorPage();
          // If not yet joined
          if (snapshot.data == "joinProgram") return JoinAmbassadorProgram();
          // Ambassador page
          return AmbassadorPage(snapshot.data);
        },
      ),
    );
  }

  Widget errorPage() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100),
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
                  builder: (context) => CampusAmbassador(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
