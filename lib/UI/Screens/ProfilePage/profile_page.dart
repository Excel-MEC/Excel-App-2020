import 'package:excelapp/Accounts/auth_service.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/alertDialog.dart';
// import 'package:excelapp/UI/Screens/ProfilePage/Widgets/referal.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/qr_code.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/update_profile.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/view_profile.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
import 'package:excelapp/UI/Themes/profile_themes.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/Services/API/registration_api.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Registration/registration.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final bool isProfileUpdated;
  ProfilePage(this.user, this.isProfileUpdated);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user;
  bool _isProfileUpdated;
  AuthService authService;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _isProfileUpdated = widget.isProfileUpdated;
    authService = AuthService();
    RegistrationAPI.fetchRegisteredEvents();
  }

  logoutUser() async {
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

  logOutConfirmation() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Do you want to Logout ?',
            style: TextStyle(fontSize: 16, color: primaryColor),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Yes",
                style: TextStyle(fontSize: 14.5, color: primaryColor),
              ),
              onPressed: () {
                // Logout
                logoutUser();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 14.5, color: primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.user.referrerAmbassadorId);
    return Scaffold(
      appBar: customappbar('Profile'),
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: <Widget>[
            // Profile and QR
            Container(
              child: QrCode(_user.picture, _user.qrCodeUrl, _user.name),
            ),
            // UNCOMMENT TO ADD REFERALS
            // (widget.user.referrerAmbassadorId == null ||
            //         widget.user.referrerAmbassadorId == 0)
            //     ? AddReferal()
            //     : referedBy(widget.user.referrer),
            // User Details
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewProfile()),
                );
              },
              child: cardBuilder('View Profile', true),
            ),
            // Update profile
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfile(_user)),
                );
              },
              child: cardBuilder('Update Profile', _isProfileUpdated),
            ),
            // Registered Events
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisteredEvents()),
                );
              },
              child: cardBuilder('Registered Events', true),
            ),
            // Logout
            GestureDetector(
              onTap: () => logOutConfirmation(),
              child: cardBuilder('Logout', true),
            ),
          ],
        ),
      ),
    );
  }
}

Widget cardBuilder(String name, bool check) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    elevation: 2,
    child: ListTile(
      // dense: true,
      title: Row(
        children: <Widget>[
          Text(
            name,
            style: ProfileTheme.detailsTextStyle,
          ),
          SizedBox(width: 5),
          check != true
              ? Icon(Icons.info_outline, color: Colors.green)
              : Container(),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
    ),
  );
}
