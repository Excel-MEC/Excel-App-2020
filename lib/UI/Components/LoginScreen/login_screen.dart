import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Login'),
      body: Center(
        child: RaisedButton(
          child: Text("Login"),
          onPressed: () {
            // TODO : Perform Authentication
            // TODO : Fetch User details
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckUserLoggedIn()));
          },
        ),
      ),
    );
  }
}