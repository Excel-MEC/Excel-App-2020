import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/Services/API/registration_api.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoinTeamPage extends StatefulWidget {
  final EventDetails eventDetails;
  final Function refreshIsRegistered;
  JoinTeamPage(
      {@required this.eventDetails, @required this.refreshIsRegistered});
  @override
  _JoinTeamPageState createState() => _JoinTeamPageState();
}

class _JoinTeamPageState extends State<JoinTeamPage> {
  final _formKey = GlobalKey<FormState>();
  int teamID;
  bool isLoading = false;
  registerEvent() async {
    var registered = await RegistrationAPI.registerEvent(
      id: widget.eventDetails.id,
      teamId: teamID,
      refreshFunction: widget.refreshIsRegistered,
      context: context,
    );
    print(registered);
    if (registered == -1) {
      print("Joining failed");
    } else if (registered != null && registered.statusCode != 200) {
      try {
        alertDialog(
          text: jsonDecode(registered.body)["error"].toString(),
          context: context,
        );
      } catch (_) {
        alertDialog(text: "Registration failed. Try again", context: context);
      }
    } else {
      EventsAPI.fetchAndStoreEventDetailsFromNet(widget.eventDetails.id);
      await Future.delayed(Duration(milliseconds: 200));
      Navigator.pop(context);
      return;
    }
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() async {
    if (!_formKey.currentState.validate()) return;
    setState(() {
      isLoading = true;
    });
    await registerEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Join Team"),
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15),
                Center(
                  child: Container(
                    height: 100,
                    child: Card(
                      elevation: 8,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.eventDetails.icon,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "You are about to join a team for the event " +
                      widget.eventDetails.name.toString() +
                      ".",
                  style: TextStyle(fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "You can get the team code by asking other team members.",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: lightTextColor,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    style: TextStyle(fontFamily: pfontFamily, fontSize: 15),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      setState(() {
                        teamID = int.parse(value);
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter ID of the required team to join";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Enter ID of team to join",
                      icon: Icon(Icons.edit),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width / 2.3,
                  height: 45.0,
                  child: RaisedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            onSubmit();
                          },
                    child: isLoading
                        ? LoadingAnimation(color: Colors.white)
                        : Text("Submit"),
                    color: primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
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
