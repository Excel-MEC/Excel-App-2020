import 'package:excelapp/Accounts/auth_service.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/alertDialog.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/qr_code.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/update_profile.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/view_profile.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
import 'package:excelapp/UI/Themes/profile_themes.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  ProfilePage(this.user);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user;
  AuthService authService;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    authService = AuthService();
  }

  logoutUser(BuildContext context) async {
    final alertDialog = alertBox("Please Wait");
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    await authService.logout();
    Navigator.of(context, rootNavigator: true).pop();
    print("Logout");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CheckUserLoggedIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Profile'),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            // Profile and QR
            Container(
              child: QrCode(_user.picture, _user.qrCodeUrl, _user.name),
            ),
            // User Details
            Expanded(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewProfile()),
                      );
                    },
                    child: cardBuilder('View Profile'),
                  ),
                  // Update profile
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfile(_user)),
                      );
                    },
                    child: cardBuilder('Update Profile'),
                  ),
                  // Registered Events
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to registered events
                    },
                    child: cardBuilder('Registered Events'),
                  ),
                  // Logout
                  GestureDetector(
                    onTap: () => logoutUser(context),
                    child: cardBuilder('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget cardBuilder(String name) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
    elevation: 3,
    child: ListTile(
      title: Text(
        name,
        style: ProfileTheme.detailsTextStyle,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
    ),
  );
}
