import 'package:excelapp/Services/API/campus_ambassador.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/AmbassadorPage/referedUsers.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class AmbassadorPage extends StatelessWidget {
  final ambassadorData;
  AmbassadorPage(this.ambassadorData);

  // Sample data
  // {id: 123,
  // ambassadorId: 456,
  // name: your name,
  // email: example@gmail.com,
  // institutionId: 456,
  // institutionName: Government Model Engineering College, Cochin,
  // gender: Male,
  // mobileNumber: 1234567890,
  // category: college,
  // freeMembership: 0,
  // paidMembership: 0
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Text(
              "Hey " + ambassadorData["name"].split(" ")[0] + ",",
              style: TextStyle(fontSize: 25, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Text(
              "You can refer others to Excel !",
              style: TextStyle(color: Color(0xaa000000)),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              height: 2,
              color: Colors.black12,
            ),
            Text(
              "Your referal code is",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xaa000000)),
            ),
            SizedBox(height: 5),
            Text(
              ambassadorData["ambassadorId"].toString(),
              style: TextStyle(fontSize: 35, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              height: 2,
              color: Colors.black12,
            ),
            FutureBuilder(
              future: getReferalList(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                if (snapshot.data == "error")
                  return Text("An error occured, Try again");
                return ReferedUsers(referedUsers: snapshot.data);
              },
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
