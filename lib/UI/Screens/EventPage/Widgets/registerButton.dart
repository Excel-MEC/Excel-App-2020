import 'dart:convert';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/registration_api.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Components/dialogWithContent/dialogWithContent.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/createTeamPage.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/joinTeamPage.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/viewTeam.dart';
import 'package:excelapp/UI/Screens/EventPage/eventPage.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

// The given file contains login related to registration of event

class RegisterButton extends StatefulWidget {
  final EventDetails eventDetails;
  RegisterButton({@required this.eventDetails});
  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  bool registered = false;
  bool isLoading = false;

  reloadPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(
          widget.eventDetails.id,
        ),
      ),
    );
  }

  openTeamPage(int teamID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewTeam(
          eventDetails: widget.eventDetails,
          teamID: teamID,
        ),
      ),
    );
  }

  void refreshIsRegistered() async {
    bool checkIfRegistered =
        await RegistrationAPI.isRegistered(widget.eventDetails.id);
    setState(() {
      registered = checkIfRegistered;
    });
  }

  register(context) async {
    String response = await RegistrationAPI.preRegistration(
        id: widget.eventDetails.id, context: context);
    if (response == "proceed") {
      // Registers for event
      // If team event, goto join team or create team
      // Else confirmation to registration is asked.
      if (widget.eventDetails.isTeam == 1) {
        await showDialog(
          context: context,
          useRootNavigator: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text('This is a team event')),
              content: Text(
                "You can either create a team or join a team. ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              actions: <Widget>[
                Center(
                  child: FlatButton(
                    child: Text("Register new team"),
                    onPressed: () {
                      Navigator.pop(context);
                      // Register as team page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTeamPage(
                            eventDetails: widget.eventDetails,
                            refreshIsRegistered: refreshIsRegistered,
                          ),
                        ),
                      ).then((_) async {
                        reloadPage();
                        return;
                      });
                    },
                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Text("Join existing team"),
                    onPressed: () {
                      Navigator.pop(context);
                      // Register as team page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JoinTeamPage(
                            eventDetails: widget.eventDetails,
                            refreshIsRegistered: refreshIsRegistered,
                          ),
                        ),
                      ).then((_) async {
                        reloadPage();
                        return;
                      });
                      return;
                    },
                  ),
                ),
              ],
            );
          },
        );
      } else {
        // Show confirmation dialog
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Are you sure you want to register ?'),
              content: Text("This cannot be undone."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Proceed"),
                  onPressed: () {
                    () async {
                      // Starts loading
                      setState(() {
                        isLoading = true;
                      });

                      await RegistrationAPI.registerEvent(
                        id: widget.eventDetails.id,
                        refreshFunction: refreshIsRegistered,
                        context: context,
                      );

                      // Ends Loading
                      setState(() {
                        isLoading = false;
                      });

                      reloadPage();
                    }();

                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else if (response == 'Already Registered' &&
        widget.eventDetails.isTeam == 1) {
      if (widget.eventDetails.registration == "null") {
        reloadPage();
        return;
      } else if (widget.eventDetails.isTeam == 1) {
        dynamic registrationDetails =
            widget.eventDetails.registration.toString();
        registrationDetails = json.decode(registrationDetails);
        var teamID = registrationDetails["teamId"];
        // var team = registrationDetails["team"];
        // print(teamID);
        // DISPLAYS TEAM ID DIALOG
        dialogWithContent(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "You have already registered for this event.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                Text(
                  "$teamID",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: primaryColor),
                ),
                SizedBox(height: 35),
                Text(
                  "is you team ID",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                RaisedButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    openTeamPage(teamID);
                  },
                  child: Text(
                    "View Team",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            context: context);
        // END OF DIALOG
      } else
        alertDialog(
            text: "You have registered for this event.", context: context);
    } else {
      // Show returned error
      alertDialog(text: response, context: context);
    }

    refreshIsRegistered();
  }

  @override
  void initState() {
    refreshIsRegistered();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 2.3,
      height: 45.0,
      child: RaisedButton(
        onPressed: () => register(context),
        child: isLoading
            ? LoadingAnimation(color: Colors.white)
            : Text(registered ? 'Registered' : 'Register'),
        color: registered ? Color(0xff337733) : primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
