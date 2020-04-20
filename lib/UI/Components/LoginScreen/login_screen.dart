import 'package:excelapp/Accounts/auth_service.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = AuthService();
  }

  authentication(BuildContext context) async {
    // Show loader
    final alertDialog = alertBox();
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    await authService.logout();
    String auth = await authService.login();
    if(auth == 'success') {
      print("Authentication Success");
    }
    else {
      print("Authentication went wrong");
    }
    // TODO : Fetch User details
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CheckUserLoggedIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Login'),
      body: Center(
        child: RaisedButton(
          child: Text("Login"),
          onPressed: () => authentication(context),
        ),
      ),
    );
  }
}

// Loading UI - Alert Dialog
Widget alertBox() {
  return AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(width: 40.0),
        Text(
          "Please Wait",
          style: TextStyle(color: Colors.grey),
        )
      ],
    ),
  );
}
