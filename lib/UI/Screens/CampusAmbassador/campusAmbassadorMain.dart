import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/API/campus_ambassador.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/AmbassadorPage/ambassadorPage.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/joinProgram.dart';
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

// Check snapshot.data.ambassador["id"] is null or not to see if user is an ambassador or not
// Professionals can't join ambassadors program
// snapshot.data.category == "professional" can be used to check if person is professional or not

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
          if (snapshot.data == "notLoggedIn")
            return Center(
              child: Text("Not logged in"),
            );
          User userData = snapshot.data;
          // If professional
          if (userData.category == "professional")
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "\n\n\nOnly school or college students can be campus ambassadors\n\nIf you are a student, update your profile in the profiles section",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xaa000000), fontSize: 16),
              ),
            );
          // If ambassador not an ambassador
          if (userData.ambassador == "null") return JoinAmbassadorProgram();
          // Ambassador page
          return AmbassadorPage(userData);
        },
      ),
    );
  }
}
