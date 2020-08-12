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

// Check snapshot.data["ambassador"]["id"] is null or not to see if user is an ambassador or not
// Professionals can't join ambassadors program
// snapshot.data["category"] == "professional" can be used to check if person is professional or not
// Full structure of data can be found in AmbassadorPage()

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
          // If professional
          if (true)
            // snapshot.data["category"] == "professional")
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "\n\n\nOnly school or college students can be campus ambassadors\n\nIf you are a student, update your profile in the profiles section",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xaa000000), fontSize: 16),
              ),
            );
          // If ambassador not an ambassador
          if (snapshot.data["ambassador"]["id"] == null)
            return JoinAmbassadorProgram();
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
