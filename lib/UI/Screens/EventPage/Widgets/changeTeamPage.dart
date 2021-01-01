import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Accounts/putAuthorisedData.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeTeamPage extends StatefulWidget {
  final EventDetails eventDetails;
  final Function refreshIsRegistered;
  ChangeTeamPage(
      {@required this.eventDetails, @required this.refreshIsRegistered});
  @override
  _ChangeTeamPageState createState() => _ChangeTeamPageState();
}

class _ChangeTeamPageState extends State<ChangeTeamPage> {
  final _formKey = GlobalKey<FormState>();
  int teamID;
  bool isLoading = false;
  registerEvent() async {
    var requestBody =
        json.encode({"eventId": widget.eventDetails.id, "teamId": teamID});
    print(requestBody);
    var response = await putAuthorisedData(
      url: APIConfig.baseUrl + '/registration/team',
      body: requestBody,
    );
    print(response.body);
    print("Changing team over with status code " +
        response.statusCode.toString());

    if (response.statusCode != 200) {
      try {
        alertDialog(text: jsonDecode(response.body)["error"], context: context);
      } catch (_) {
        alertDialog(text: "Changing Team failed. Try again", context: context);
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
    try {
      await registerEvent();
    } catch (_) {
      alertDialog(text: "Changing Team failed. Try again", context: context);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Change Team"),
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
                  "You will be removed from the current team if you change team." +
                      widget.eventDetails.name.toString() +
                      ".",
                  style: TextStyle(fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "Enter the ID of the team you wish to join.",
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
                        return "Enter ID of the new team";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Enter ID of new team",
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
