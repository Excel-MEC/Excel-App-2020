import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _mobile;
  List<String> _categories = <String>['college','school','professional'];
  String _category = 'college';
  List<String> _institutions = <String>['Harvard','Mec','Stanford','MIT','IIT Bombay'];
  String _institutionName = 'Mec';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Update Profile'),
      // TODO: future Builder to fetch list of institutions from backend
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              // Name
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
              // Mobile Number
              TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (String value) {
                  setState(() {
                    _mobile = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter your mobile number";
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Mobile No:',
                  labelStyle: TextStyle(color: primaryColor),
                ),
              ),
              // Category
              Row(
                children: <Widget>[
                  Text("Category: "),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                   value: _category,
                   items: _categories.map<DropdownMenuItem<String>>((val) {
                     return DropdownMenuItem<String>(
                       value: val,
                       child: Text(val),
                     );
                   }).toList(),
                   onChanged: (String value) {
                     setState(() {
                       _category = value;
                     });
                   },
                  ),
                ],
              ),

              // Institutions
              // TODO: Implement searchable drop down list
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  _formKey.currentState.save();
                  // TODO: It return whether form is valid or not. Therefore appropriate steps can be taken
                  _formKey.currentState.validate();
                },
              ),
              Text(_category)
            ],
          ),
        ),
      ),
    );
  }
}
