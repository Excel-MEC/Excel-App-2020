import 'package:excelapp/Services/API/campus_ambassador.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/campusAmbassadorMAin.dart';
import 'package:flutter/material.dart';

class JoinAmbassadorProgram extends StatelessWidget {
  joinProgram(context) async {
    var reponse = await joinAmbassadorProgram();
    if (reponse == "error") {
      alertDialog(text: "An Error Occured", context: context);
      return;
    } else
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CampusAmbassador()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text("You are not an Excel campus ambassador yet !"),
          SizedBox(height: 20),
          Text(
              "Become a campus ambassador, refer friends and enjoy the benefits"),
          SizedBox(height: 20),
          RaisedButton(
            child: Text("Join Program"),
            onPressed: () {
              joinProgram(context);
            },
          ),
        ],
      ),
    );
  }
}
