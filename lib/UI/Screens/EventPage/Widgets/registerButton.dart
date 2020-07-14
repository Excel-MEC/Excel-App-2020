import 'package:excelapp/Services/API/registration_api.dart';
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

  void refreshIsRegistered() async {
    bool checkIfRegistered = await RegistrationAPI.isRegistered(widget.eventId);
    print('Registartion response $checkIfRegistered');
    setState(() {
      registered = checkIfRegistered;
    });
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
        onPressed: () {
          RegistrationAPI.registerEvent(
            id: widget.eventId,
            refreshFunction: refreshIsRegistered,
            context: context,
          );
        },
        child: Text(registered ? 'Registered' : 'Register'),
        color: registered ? Color(0xff337733) : primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
