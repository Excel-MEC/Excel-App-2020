import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is used to check if User has logged in or not
// If logged in then take user to profile page

class CheckUserLoggedIn extends StatefulWidget {
  @override
  _CheckUserLoggedInState createState() => _CheckUserLoggedInState();
}

class _CheckUserLoggedInState extends State<CheckUserLoggedIn> {

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  // Check if user is authenticated
  void checkUser() async {
    // TODO: Evaluate User
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}