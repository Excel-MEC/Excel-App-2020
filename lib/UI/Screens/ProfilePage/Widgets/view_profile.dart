import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:excelapp/UI/constants.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  var userDetails;
  @override
  void initState() {
    userDetails = viewUserProfile();
    super.initState();
  }

  Future<dynamic> viewUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isProfileUpdated') == false ||
        prefs.getBool('isProfileUpdated') == null) {
      return "Not Updated";
    } else {
      User user = await AccountServices.viewProfile();
      if (user == null) return "error";
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('View Profile'),
      body: FutureBuilder(
        future: userDetails,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "Not Updated") {
              return Center(child: Text("Profile not updated"));
            }

            if (snapshot.data == "error") {
              return Center(child: Text("An error occured, Try again"));
            } else {
              return viewProfileBody(snapshot.data, context);
            }
          } else {
            return LoadingAnimation();
          }
        },
      ),
    );
  }
}

Widget viewProfileBody(User userData, context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 0),
            details('Name', userData.name, Icons.person),
            details('Email', userData.email, Icons.email),
            details('Excel ID', userData.id.toString(), Icons.confirmation_num),
            details('Gender', userData.gender, Icons.face),
            details('Mobile', userData.mobileNumber, Icons.phone),
            details(
              userData.category[0].toUpperCase() +
                  userData.category.substring(1),
              userData.institutionName,
              Icons.home,
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    ),
  );
}

Widget details(String field, String value, var icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: ListTile(
        dense: true,
        leading: CircleAvatar(
          backgroundColor: primaryColor,
          child: Icon(
            icon,
            color: Colors.white,
            size: 15,
          ),
        ),
        title: Text(
          field == "Others" ? "Category" : field,
          style: TextStyle(color: primaryColor),
        ),
        subtitle: Text(
          field == "Others" ? "Others" : (value ?? ""),
          style: TextStyle(fontFamily: pfontFamily),
        )),
  );
}
