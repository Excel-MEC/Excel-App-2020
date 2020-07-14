import 'package:excelapp/Services/API/registration_api.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatefulWidget {
  final int eventId;
  RegisterButton({@required this.eventId});
  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  bool registered = false;
  bool isLoading = false;

  void refreshIsRegistered() async {
    bool checkIfRegistered = await RegistrationAPI.isRegistered(widget.eventId);
    setState(() {
      registered = checkIfRegistered;
    });
  }

  register(context) async {
    setState(() {
      isLoading = true;
    });
    String response = await RegistrationAPI.preRegistration(
        id: widget.eventId, context: context);
    if (response == "proceed") {
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
                    await RegistrationAPI.registerEvent(
                      id: widget.eventId,
                      refreshFunction: refreshIsRegistered,
                      context: context,
                    );
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
    } else {
      // Show returned error
      alertDialog(text: response, context: context);
      setState(() {
        isLoading = false;
      });
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
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
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
