import 'dart:convert';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/registration_api.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Components/dialogWithContent/dialogWithContent.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/changeTeamPage.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/createTeamPage.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/joinTeamPage.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/viewTeam.dart';
import 'package:excelapp/UI/Screens/EventPage/eventPage.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Drawer/drawer.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_share/social_share.dart';

// The given file contains logic related to registration of event & the button

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

  openJoinTeamPage(int teamID) {
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

  openChangeTeamPage(int teamID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeTeamPage(
          eventDetails: widget.eventDetails,
          refreshIsRegistered: refreshIsRegistered,
        ),
      ),
    ).then((_) async {
      reloadPage();
      return;
    });
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
                  "Share this team Id with your teammates to add them to team",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xaa000000)),
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30),
                    Text(
                      "$teamID",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: primaryColor),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.content_copy,
                        size: 28,
                        color: Colors.grey,
                      ),
                      onPressed: () async {
                        await SocialShare.copyToClipboard(
                          teamID.toString(),
                        );
                        // alertDialog(text: "Copied", context: context);
                        Fluttertoast.showToast(
                          msg: "Copied",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0x77000000),
                          textColor: Colors.white,
                          fontSize: 11.0,
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 35),
                Text(
                  "is your team ID",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xaa000000)),
                ),
                SizedBox(height: 35),
                FractionallySizedBox(
                  widthFactor: .8,
                  child: RaisedButton(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      openJoinTeamPage(teamID);
                    },
                    child: Text(
                      "View Team",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: .8,
                  child: RaisedButton(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (widget.eventDetails.registrationOpen == 1)
                        openChangeTeamPage(teamID);
                      else
                        alertDialog(
                          text:
                              "Registrations for this event has been closed. \n\nTeam change operation cannot be performed.",
                          context: context,
                        );
                    },
                    child: Text(
                      "Change Team",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            context: context);
        // END OF DIALOG
      }
    } else if (response == 'Already Registered')
      alertDialog(
          text: "You have registered for this event.", context: context);
    else {
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
    String buttonText = "";
    Color buttonColor = primaryColor;

    if (widget.eventDetails.needRegistration == 1) {
      if (registered) {
        buttonText =
            widget.eventDetails.isTeam == 1 ? 'Manage Team' : 'Registered';
        buttonColor = registered ? Color(0xff335533) : primaryColor;
      } else if (widget.eventDetails.registrationOpen == 1) {
        buttonText = "Register";
        buttonColor = primaryColor;
      } else {
        buttonText = "Registration Closed";
        buttonColor = Color(0xff7d141d);
      }
    } else {
      if (widget.eventDetails.button == null) {
        // Should not happen
      } else {
        buttonText = widget.eventDetails.button.toString();
        buttonColor = primaryColor;
      }
    }
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 2.3,
      height: 45.0,
      child: RaisedButton(
        onPressed: () {
          if (widget.eventDetails.needRegistration == 1) {
            if (registered) {
              register(context);
            } else if (widget.eventDetails.registrationOpen == 1) {
              register(context);
            } else {
              alertDialog(text: "Registration Closed", context: context);
            }
          } else if (widget.eventDetails.registrationLink != null) {
            launchURL(widget.eventDetails.registrationLink.toString());
          }
        },
        child: isLoading
            ? LoadingAnimation(color: Colors.white)
            : Text(buttonText),
        color: buttonColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
