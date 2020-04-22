import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Accounts/auth_service.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/alertDialog.dart';
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

  void authentication(BuildContext context) async {
    final alertDialog = alertBox("Please Wait");
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    // Logout and  then Login
    await authService.logout();
    String auth = await authService.login();

    if (auth == 'success') {
      // Fetch User details and Update local database - User table
      await AccountServices.fetchUserDetails();
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      print("Authentication went wrong");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CheckUserLoggedIn()),
    );
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
