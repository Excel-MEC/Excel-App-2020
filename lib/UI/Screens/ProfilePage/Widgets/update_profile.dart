import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/alertDialog.dart';
import 'package:excelapp/UI/Components/LoadingUI/snackBar.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
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

  // Initialize form fields
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
  Future<String> submitForm() async {
    setState(() {});
    final alertDialog = alertBox("Submitting Form");
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    // get institutionId only if category is school or professional
    if (_category != "professional") {
      _institutionId = await getInstitutionId(_institutionName);
    }
    if (_institutionId < 0) {
      Navigator.of(context, rootNavigator: true).pop();
      return "One or more fields are invalid!";
    }

    Map<String, dynamic> userInfo = {
      "name": _name,
      "institutionId": _institutionId,
      "institutionName": _institutionName,
      "gender": _gender,
      "mobileNumber": _mobile,
      "category": _category
    };

    var res = await AccountServices.updateProfile(userInfo);
    print(res);
    Navigator.of(context, rootNavigator: true).pop();
    return "Submitted";
  }

  // Method to get institution Id
  Future<int> getInstitutionId(String institutionName) async {
    int id = -1;
    institutions.forEach((e) {
      if (institutionName == e.name) {
        id = e.id;
      }
    });
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customappbar('Update Profile'),
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: primaryColor,
        ),
        child: Container(
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
                    style: TextStyle(fontFamily: pfontFamily, fontSize: 15),
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
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      labelStyle: TextStyle(color: primaryColor),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: primaryColor)),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Mobile Number
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontFamily: pfontFamily, fontSize: 15),
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
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      labelStyle: TextStyle(color: primaryColor),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      icon: Icon(Icons.phone_android),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: primaryColor)),
                    ),
                  ),
                  SizedBox(height: 25),
                  // Select Gender
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Gender: ",
                          style: TextStyle(fontFamily: pfontFamily),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        decoration: BoxDecoration(
                            border: Border.all(width: .5),
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          style: TextStyle(
                              fontFamily: pfontFamily, color: primaryColor),
                          underline: Center(),
                          icon: Icon(Icons.keyboard_arrow_down),
                          value: _gender,
                          items: _genders.map<DropdownMenuItem<String>>((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                                style: TextStyle(
                                    fontFamily: pfontFamily,
                                    color: primaryColor,
                                    fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Select Category
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Category: ",
                          style: TextStyle(fontFamily: pfontFamily),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          border: Border.all(width: .5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          value: _category,
                          isExpanded: true,
                          isDense: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          underline: Center(),
                          hint: Text("Select Category"),
                          items:
                              _categories.map<DropdownMenuItem<String>>((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val[0].toUpperCase() + val.substring(1),
                                style: TextStyle(
                                    fontFamily: pfontFamily,
                                    fontSize: 14,
                                    color: primaryColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              _category = value;
                            });
                            if (value == "professional") {
                              setState(() {
                                categorySelected = true;
                                _institutionId = 0;
                              });
                            }
                            if (value != "professional") {
                              getInstitutions(context, value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Select Institution
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Note - Professionals
                      Text(
                        "Note : Not applicable for professionals",
                        style: TextStyle(
                            fontFamily: pfontFamily, color: primaryColor),
                      ),
                      categorySelected
                          ? Text(" ")
                          : Text(
                              "\nSelect category first\n",
                              style: TextStyle(color: Colors.red),
                            ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: .5)),
                              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: SearchableDropdown.single(
                                underline: Center(),
                                // value: _institutionName,
                                readOnly: !categorySelected ||
                                    _category == "professional",
                                items: institutions
                                    .map<DropdownMenuItem<String>>((val) {
                                  return DropdownMenuItem<String>(
                                    value: val.name,
                                    child: Text(
                                      val.name.toString(),
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14,
                                          fontFamily: pfontFamily),
                                    ),
                                  );
                                }).toList(),
                                hint: 'Select Institution',
                                style: TextStyle(
                                    fontFamily: pfontFamily, fontSize: 14),
                                icon: Icon(Icons.keyboard_arrow_down),
                                searchHint: 'Enter Institution Name',
                                onChanged: (value) {
                                  setState(() {
                                    _institutionName = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 30),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: primaryColor,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontFamily: pfontFamily, color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState.save();
                      _formKey.currentState.validate()
                          ? submitForm().then((value) {
                              if (value == "Submitted") {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckUserLoggedIn(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              } else {
                                Scaffold.of(context)
                                    .showSnackBar(snackBar(value));
                              }
                            }).catchError((e) => print(e))
                          : print("Not valid");
                    },
                  ),
                  SizedBox(height: 80)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
