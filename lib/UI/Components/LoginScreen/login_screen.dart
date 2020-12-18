import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Accounts/auth_service.dart';
import 'package:excelapp/Services/API/favourites_api.dart';
import 'package:excelapp/UI/Components/Appbar/darkAppbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/alertDialog.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
import 'package:excelapp/UI/constants.dart';
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
      // Refresh fvourites
      FavouritesStatus.instance.favouritesStatus = 3;
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
      appBar: darkAppbar(),
      body: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          image: DecorationImage(
            image: AssetImage('assets/BG 2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 6,
                  child: Image(
                    image: AssetImage("assets/excel logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Excel 2020  |  Accounts",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 100),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                    color: Colors.white,
                    textColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text("Login"),
                    onPressed: () => authentication(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
