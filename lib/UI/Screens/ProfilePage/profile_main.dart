import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:excelapp/UI/Components/LoginScreen/login_screen.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckUserLoggedIn extends StatefulWidget {
  @override
  _CheckUserLoggedInState createState() => _CheckUserLoggedInState();
}

class _CheckUserLoggedInState extends State<CheckUserLoggedIn> {
  DBProvider db;
  bool profileUpdated;

  @override
  void initState() {
    super.initState();
    db = DBProvider();
  }

  Future<dynamic> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogged') == false ||
        prefs.getBool('isLogged') == null) {
      return 'login';
    } else {
      // Fetch user details from database
      int userId = prefs.getInt('userId');
      bool isProfileUpdated = prefs.getBool('isProfileUpdated');
      setState(() {
        profileUpdated = isProfileUpdated;
      });
      User user = await db.getUser('User', userId);
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: checkUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'login') {
              return LoginScreen();
            } else {
              return ProfilePage(snapshot.data,profileUpdated);
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
