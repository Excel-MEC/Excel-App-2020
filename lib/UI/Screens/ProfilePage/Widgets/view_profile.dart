import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:excelapp/UI/constants.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {

  @override
  void initState() {
    super.initState();
  }

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
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 8),
          Container(
            child: Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    details('Name', userData.name, Icons.person),
                    details('Email', userData.email, Icons.email),
                    details('Gender', userData.gender, Icons.face),
                    details('Mobile', userData.mobileNumber, Icons.phone),
                    details(
                      userData.category[0].toUpperCase() +
                          userData.category.substring(1),
                      userData.institutionName,
                      Icons.home,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget details(String field, String value, var icon) {
  return ListTile(
    leading: Icon(icon,color: primaryColor),
    title: Text(
      field,
      style: TextStyle(
        color: primaryColor,
        fontFamily: pfontFamily,
      ),
    ),
    subtitle: Text(value),
  );
}