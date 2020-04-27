import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      appBar: customappbar('View Profile'),
      body: FutureBuilder(
        future: viewUserProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "Not Updated") {
              return Center(child: Text("Profile not updated"));
            } else {
              // TODO : Proper UI for View Profile
              return Container(
                child: Column(
                  children: <Widget>[
                    Text(snapshot.data.name),
                    Text(snapshot.data.email),
                    Text(snapshot.data.category),
                    Text(snapshot.data.institutionName),
                    Text(snapshot.data.gender),
                    Text(snapshot.data.mobileNumber),
                  ],
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
