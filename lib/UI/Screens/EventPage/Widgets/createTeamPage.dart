import 'package:excelapp/Models/event_Team.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/Services/API/registration_api.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class CreateTeamPage extends StatefulWidget {
  final EventDetails eventDetails;
  final Function refreshIsRegistered;
  CreateTeamPage(
      {@required this.eventDetails, @required this.refreshIsRegistered});
  @override
  _CreateTeamPageState createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final _formKey = GlobalKey<FormState>();
  String teamName;
  bool isLoading = false;
  createTeam() async {
    TeamDetails teamdetails =
        await RegistrationAPI.createTeam(teamName, widget.eventDetails.id);
    if (teamdetails != null) {
      var registered = await RegistrationAPI.registerEvent(
        id: widget.eventDetails.id,
        teamId: teamdetails.id,
        refreshFunction: widget.refreshIsRegistered,
        context: context,
      );

      if (registered == -1)
        alertDialog(text: "An error occured", context: context);
      else {
        EventsAPI.fetchAndStoreEventDetailsFromNet(widget.eventDetails.id);
        await Future.delayed(Duration(milliseconds: 200));
        Navigator.pop(context);
        return;
      }
      setState(() {
        isLoading = false;
      });
    } else
      alertDialog(
        text: "Team creation failed",
        context: context,
      );
  }

  onSubmit() async {
    if (!_formKey.currentState.validate()) return;
    setState(() {
      isLoading = true;
    });
    await createTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Create Team"),
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    style: TextStyle(fontFamily: pfontFamily, fontSize: 15),
                    onSaved: (String value) {
                      setState(() {
                        teamName = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter a team name";
                      }
                      if (value.length < 5) {
                        return "Enter atleast 5 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Team Name",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
