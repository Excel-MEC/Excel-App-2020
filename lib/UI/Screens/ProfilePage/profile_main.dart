import 'package:excelapp/UI/Components/LoginScreen/login_screen.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CheckUserLoggedIn extends StatefulWidget {
  @override
  _CheckUserLoggedInState createState() => _CheckUserLoggedInState();
}

class _CheckUserLoggedInState extends State<CheckUserLoggedIn> {

  Future<String> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogged') == false ||
        prefs.getBool('isLogged') == null) {
          return 'login';
    } else {
      // fetch user details from DB -- setState
      // return 'profile';
    }
    return 'null';
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
            } else if (snapshot.data == 'profile') {
              return ProfilePage();
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
