import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:excelapp/UI/constants.dart';

class ViewProfile extends StatelessWidget {
  Future<dynamic> viewUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isProfileUpdated') == false ||
        prefs.getBool('isProfileUpdated') == null) {
      return "Not Updated";
    } else {
      User user = await AccountServices.viewProfile();
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: customappbar('View Profile'),
      body: FutureBuilder(
        future: viewUserProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "Not Updated") {
              return Center(child: Text("Profile not updated"));
            } else {
              return viewProfileBody(snapshot.data, context);
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget viewProfileBody(User userData, context) {
  return Container(
    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
    child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // User Details
                  detailItem('Name', userData.name, Icons.person),
                  line(),
                  detailItem('Email', userData.email, Icons.email),
                  line(),
                  detailItem('Gender', userData.gender, Icons.face),
                  line(),
                  detailItem('Phone No.', userData.mobileNumber, Icons.phone),
                  line(),
                  // Capitalises First letter of Institution type.
                  detailItem(
                      userData.category[0].toUpperCase() +
                          userData.category.substring(1),
                      userData.institutionName,
                      Icons.home),
                  SizedBox(height: 10)
                ],
              ),
            ),
            SizedBox(height: 100)
          ]),
    ),
  );
}

Widget detailItem(String fieldName, String value, var icon) {
  return Container(
      // padding: EdgeInsets.fromLTRB(2, 10, 2, 2),
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      ListTile(
        title: Row(
          children: <Widget>[
            Icon(
              icon,
              color: primaryColor,
              size: 18,
            ),
            SizedBox(width: 5),
            Text(
              fieldName,
              style: TextStyle(
                  color: primaryColor, fontFamily: pfontFamily, fontSize: 15),
            ),
          ],
        ),
        subtitle: Text(
          value,
          style: TextStyle( fontFamily: pfontFamily),
        ),
      ),
    ],
  ));
}

Widget line() {
  return Container(
    margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
    height: 2,
    color: Colors.grey[300],
  );
}
