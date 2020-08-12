import 'package:excelapp/Services/API/campus_ambassador.dart';
import 'package:excelapp/UI/Screens/CampusAmbassador/AmbassadorPage/referedUsers.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class AmbassadorPage extends StatefulWidget {
  final Map<String, dynamic> ambassadorData;
  AmbassadorPage(this.ambassadorData);
  @override
  _AmbassadorPageState createState() => _AmbassadorPageState();
}

class _AmbassadorPageState extends State<AmbassadorPage> {
  Map<String, dynamic> ambassadorData;
  Future referalList;

  @override
  void initState() {
    ambassadorData = widget.ambassadorData;
    referalList = getReferalList();
    super.initState();
  }

// Sample Data
// var ambassadorData = {
//   "id": 123,
//   "name": "Name",
//   "email": "email@gmail.com",
//   "role": "User,Admin",
//   "picture":
//       "url.png",
//   "qrCodeUrl":
//       "url.png",
//   "institutionId": 456,
//   "gender": "Male",
//   "mobileNumber": "1234567890",
//   "category": "college",
//   "ambassador": {
//     "id": 123456,
//     "userId": 123456,
//     "referredUsers": null,
//     "freeMembership": 4,
//     "paidMembership": 0
//   },
//   "referrerAmbassadorId": null,
//   "referrer": null,
//   "isPaid": false
// };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            Text(
              "Hello " + ambassadorData["name"].split(" ")[0] + ",",
              style: TextStyle(fontSize: 25, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            Image.asset("assets/refer.png", height: 150),
            SizedBox(height: 30),
            Text(
              "Share this code to other users\n to add them as referals",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xaa000000)),
            ),
            SizedBox(height: 5),
            // Row with referal code
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
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
                children: [
                  SizedBox(width: 30),
                  Text(
                    ambassadorData["ambassador"]["id"].toString(),
                    style: TextStyle(fontSize: 37, color: primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      Icons.content_copy,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      print("object");
                    },
                  )
                ],
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
                  builder: (context) => AmbassadorPage(ambassadorData),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
