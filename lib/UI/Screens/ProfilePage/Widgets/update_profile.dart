import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/alertDialog.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class UpdateProfile extends StatefulWidget {
  final User user;
  UpdateProfile(this.user);
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool categorySelected;
  List<Institution> institutions = [];

    // Form Fields
  final _formKey = GlobalKey<FormState>();
  int _id;
  String _name;
  String _mobile;
  String _category;
  int _institutionId;
  String _institutionName;
  String _gender = 'Male';
  List<String> _categories = <String>['college', 'school', 'professional'];
  List<String> _genders = <String>['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    initialiseUserDetails(widget.user);
    categorySelected = false;
  }

  initialiseUserDetails(User user) {
    _id = user.id;
    _name = user.name;
    _mobile = user.mobileNumber;
    _category = user.category != "Not Registered" ? user.category : "college";
    _institutionId = user.institutionId;
    _institutionName = user.institutionName;
  }

  // Fetch institutions based on category
  getInstitutions(BuildContext context, String category) async {
    final alertDialog = alertBox("Fetching Institutions");
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    List<Institution> res = await AccountServices.fetchInstitutions(category);
    setState(() {
      institutions.clear();
      institutions.addAll(res);
      categorySelected = true;
    });
    Navigator.of(context, rootNavigator: true).pop();
  }


  // Submit Form
  submitForm() async {
    setState(() {});
    final alertDialog = alertBox("Submitting Form");
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    _institutionId = await getInstitutionId(_institutionName);
    Map<String,dynamic> userInfo = {
      "name"            : _name,
      "institutionId"   : _institutionId,
      "institutionName" : _institutionName,
      "gender"          : _gender,
      "mobileNumber"    : _mobile,
      "category"        : _category
    };
    
    var res = await AccountServices.updateProfile(userInfo);
    print(res);
    // TODO : Display snack bar indicating if submission was a success or not
    Navigator.of(context, rootNavigator: true).pop();
  }
  
  Future<int> getInstitutionId(String institutionName) async {
    int id;
    institutions.forEach((e) {
      if(institutionName == e.name) {
        id = e.id;
      }
    });
    return id;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Update Profile'),
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
                  initialValue: _name,
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
                    if (value.length > 10) {
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
                      hint: Text("Select Category"),
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
                        if (value != "professional") {
                          getInstitutions(context, value);
                        }
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
                    categorySelected ? Text(" ") : Text("Select category first",style: TextStyle(color: Colors.red),),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SearchableDropdown.single(
                            value: _institutionName,
                            readOnly: !categorySelected || _category == "professional",
                            items: institutions
                                .map<DropdownMenuItem<String>>((val) {
                              return DropdownMenuItem<String>(
                                value: val.name,
                                child: Text(val.name),
                              );
                            }).toList(),
                            hint: 'Select Institution',
                            searchHint: 'Enter Institution Name',
                            onChanged: (value) {
                              setState(() {
                                _institutionName = value;
                              });
                            },
                            validator: (val) {
                              if(val == "Not Registered") {
                                return "Select Institution";
                              }
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 30),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    _formKey.currentState.save();
                    // TODO: It return whether form is valid or not. Therefore appropriate steps can be taken
                    _formKey.currentState.validate() ? submitForm() : print("Not valid");
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
