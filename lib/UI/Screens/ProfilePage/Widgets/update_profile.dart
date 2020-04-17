import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Update Profile'),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter your name";
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelStyle: TextStyle(color: primaryColor),
                ),
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  _formKey.currentState.save();
                  // TODO: It return whether form is valid or not. Therefore appropriate steps can be taken
                  _formKey.currentState.validate();
                },
              ),
              Text(_name)
            ],
          ),
        ),
      ),
    );
  }
}
