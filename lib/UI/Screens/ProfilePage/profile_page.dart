import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/qr_code.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/update_profile.dart';
import 'package:excelapp/UI/Themes/profile_themes.dart';
import 'package:excelapp/UI/constants.dart';
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
                child: QrCode(user.imageUrl, user.qrUrl, user.name),
              ),
              // Update profile
               GestureDetector(
                onTap: (){
                  // TODO: Update Profile
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile()));
                },
                child: cardBuilder('Update Profile'),
              ),
              // Registered Events
               GestureDetector(
                onTap: (){
                  // TODO: Navigate to registered events
                },
                child: cardBuilder('Registered Events'),
              ),
              // Logout
               GestureDetector(
                onTap: (){
                  // TODO: Perform logout
                },
                child: cardBuilder('Logout'),
              ),
            ],
          ),
        ));
  }
}

Widget cardBuilder(String name) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 4),
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
