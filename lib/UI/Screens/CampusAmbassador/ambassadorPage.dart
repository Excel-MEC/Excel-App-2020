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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Text(
            "Hey " + ambassadorData["name"].split(" ")[0] + ",",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Text(
            "You can refer others to Excel !",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Text(
            "Your referal code is",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            ambassadorData["ambassadorId"].toString(),
            style: TextStyle(fontSize: 35),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
