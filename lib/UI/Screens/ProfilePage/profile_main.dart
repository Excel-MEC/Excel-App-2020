import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Components/LoginScreen/login_screen.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckUserLoggedIn extends StatefulWidget {
  @override
  _CheckUserLoggedInState createState() => _CheckUserLoggedInState();
}

class _CheckUserLoggedInState extends State<CheckUserLoggedIn> {
  bool isProfileUpdated;
  Future userData;

  Future<dynamic> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogged') == false ||
        prefs.getBool('isLogged') == null) {
      return 'login';
    } else {
      // Fetch user details from database
      isProfileUpdated = prefs.getBool('isProfileUpdated') ?? false;
      var user = await HiveDB.retrieveData(valueName: "user");
      if (user == null) return "login";
      return User.fromJson(user);
    }
  }

  @override
  void initState() {
    userData = checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: userData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'login') {
              return LoginScreen();
            } else {
              return ProfilePage(snapshot.data, isProfileUpdated);
            }
          } else {
            return LoadingAnimation();
          }
        },
      ),
    );
  }
}
