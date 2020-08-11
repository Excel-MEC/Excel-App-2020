import 'package:excelapp/Services/API/campus_ambassador.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/ambassadorPage.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/joinProgram.dart';
import 'package:flutter/material.dart';

class CampusAmbassador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Campus Ambassador"),
      body: FutureBuilder(
        future: fetchAmbassadorDetails(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.data == "notLoggedIn") return Text("Not logged in");
          if (snapshot.data == "error")
            return Center(child: Text("An error occured, Try again"));
          if (snapshot.data == "joinProgram") return JoinAmbassadorProgram();
          return AmbassadorPage(snapshot.data);
        },
      ),
    );
  }
}
