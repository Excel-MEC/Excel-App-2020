import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

// TODO: Fetch institutions from API
// TODO: Send data to backend

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _mobile;
  List<String> _categories = <String>['college', 'school', 'professional'];
  String _category = 'college';
  List<String> _genders = <String>['Male', 'Female', 'Other'];
  String _gender = 'Male';
  List<String> _institutions = <String>[
    'Harvard',
    'Model Engineering College',
    'Stanford',
    'MIT',
    'IIT Bombay',
    'HArry Potter Uni',
    'Other',
  ];
  String _institutionName = 'Model Engineering College';

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
          child: SingleChildScrollView(
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
                SizedBox(height: 10),
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
                    if(value.length > 10) {
                      return "Invalid Mobile number";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Mobile No:',
                    labelStyle: TextStyle(color: primaryColor),
                  ),
                ),
                SizedBox(height: 10),
                // Select Category
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
                SizedBox(height: 20),
                // Select Institution
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Note - Professionals
                    Text("Note : Not applicable for professionals"),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SearchableDropdown.single(
                            value: _institutionName,
                            items: _institutions
                                .map<DropdownMenuItem<String>>((val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            }).toList(),
                            hint: 'Select Institution',
                            searchHint: 'Enter Institution Name',
                            onChanged: (value) {
                              setState(() {
                                _institutionName = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Select Gender
                Row(
                  children: <Widget>[
                    Text("Gender: "),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _gender,
                      items: _genders.map<DropdownMenuItem<String>>((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    _formKey.currentState.save();
                    // TODO: It return whether form is valid or not. Therefore appropriate steps can be taken
                    _formKey.currentState.validate();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
