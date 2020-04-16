import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/qr_code.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Person user = Person();

  @override
  void initState() {
    super.initState();
    // TODO: Replace with data from endpoint
    user = Person.fromMapObject(userMap);
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
                height: MediaQuery.of(context).size.height/2.5,
                child: QrCode(user.imageUrl, user.qrUrl, user.name),
              )
              // User Details
              // UserDetails(),
              // Update profile
              // UpdateProfile(),
              // Registered Events
              // RegisteredEvents(),
              // Logout
              // Logout(),
            ],
          ),
        ));
  }
}
