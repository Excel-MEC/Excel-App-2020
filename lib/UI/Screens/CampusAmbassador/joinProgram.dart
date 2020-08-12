import 'package:excelapp/Services/API/campus_ambassador.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/campusAmbassadorMAin.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class JoinAmbassadorProgram extends StatefulWidget {
  @override
  _JoinAmbassadorProgramState createState() => _JoinAmbassadorProgramState();
}

class _JoinAmbassadorProgramState extends State<JoinAmbassadorProgram> {
  bool loading = false;

  joinProgram(context) async {
    setState(() {
      loading = true;
    });
    var reponse = await joinAmbassadorProgram();
    setState(() {
      loading = false;
    });
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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: 10),
          Image.asset("assets/campusAmbassador/higher.png"),
          SizedBox(height: 10),
          Text(
            "You are not an Excel campus ambassador yet !",
            style: TextStyle(fontSize: 22, color: Color(0xaa000000)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            "Become a campus ambassador, refer friends and enjoy the benefits",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          loading
              ? CircularProgressIndicator()
              : RaisedButton(
                  color: primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Join Program",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    joinProgram(context);
                  },
                ),
        ],
      ),
    );
  }
}
