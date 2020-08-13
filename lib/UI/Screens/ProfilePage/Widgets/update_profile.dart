import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/alertDialog.dart';
import 'package:excelapp/UI/Components/LoadingUI/snackBar.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // int _id;
  String _name;
  String _mobile;
  int _categoryId;
  int _institutionId;
  String _institutionName;
  String _gender;
  bool _institutionSelected = false;
  List<String> _categories = <String>['College', 'School', 'Other'];
  List<String> _genders = <String>['Male', 'Female', 'Other'];

// Category id's & their values:
// 0: College
// 1: School
// 2: Other

  @override
  void initState() {
    super.initState();
    initialiseUserDetails(widget.user);
    categorySelected = false;
  }

  // Initialize form fields
  initialiseUserDetails(User user) {
    // _id = user.id;
    _name = user.name;
    _mobile = user.mobileNumber;
    // _category = user.category != "Not Registered" ? user.category : "college";
    _institutionId = user.institutionId;
    _institutionName = user.institutionName;
    _gender = user.gender;
  }

  // Fetch institutions based on category
  getInstitutions(BuildContext context, String category) async {
    final loadingDialog = alertBox("Fetching Institutions");
    showDialog(
      context: context,
      builder: (BuildContext context) => loadingDialog,
      barrierDismissible: false,
    );

    try {
      List<Institution> res = await AccountServices.fetchInstitutions(category);

      setState(() {
        institutions.clear();
        institutions.addAll(res);
        categorySelected = true;
      });
      Navigator.of(context, rootNavigator: true).pop();
    } catch (_) {
      Navigator.of(context, rootNavigator: true).pop();
      alertDialog(
        text: "Failed to fetch institutions\nTry again",
        context: context,
      );
    }
  }

  // Submit Form
  Future submitForm() async {
    setState(() {});
    final loadingDialog = alertBox("Submitting Form");
    showDialog(
      context: context,
      builder: (BuildContext context) => loadingDialog,
      barrierDismissible: false,
    );
    if (_gender == null || _gender == "Not Registered") {
      Navigator.of(context, rootNavigator: true).pop();
      return "Gender not selected";
    }

    // get institutionId only if category is school or college
    if (_categoryId != 2) {
      _institutionId = await getInstitutionId(_institutionName);
    }
    if (_institutionId < 0) {
      Navigator.of(context, rootNavigator: true).pop();
      return "One or more fields are invalid!";
    }
    if (_categoryId != 2 && !_institutionSelected) {
      Navigator.of(context, rootNavigator: true).pop();
      return "Select institution";
    }
    Map<String, dynamic> userInfo = {
      "name": _name,
      "institutionId": _institutionId,
      "institutionName": _institutionName,
      "gender": _gender,
      "mobileNumber": _mobile,
      "categoryId": _categoryId.toString()
    };
    print(userInfo);
    var res = await AccountServices.updateProfile(userInfo);
    Navigator.of(context, rootNavigator: true).pop();
    if (res == "error")
      alertDialog(text: "Something went wrong", context: context);
    else {
      return "Submitted";
    }
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
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
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
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                      icon: Icon(Icons.person),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Mobile Number
                  TextFormField(
                    initialValue: _mobile == "Not Registered" ? "" : _mobile,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
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
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Mobile",
                      icon: Icon(Icons.phone),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Select Gender
                  Row(
                    children: <Widget>[
                      Text("Gender: "),
                      SizedBox(width: 15),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          style: TextStyle(color: primaryColor),
                          underline: Center(),
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Text(
                              (_gender == "Not Registered" || _gender == null)
                                  ? "Select Gender"
                                  : _gender),
                          items: _genders.map<DropdownMenuItem<String>>((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                ),
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
                      Text("Category: "),
                      SizedBox(width: 5),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          style: TextStyle(color: primaryColor),
                          icon: Icon(Icons.keyboard_arrow_down),
                          underline: Center(),
                          hint: Text(
                            categorySelected
                                ? _categories[_categoryId]
                                : "Select Category",
                          ),
                          items:
                              _categories.map<DropdownMenuItem<String>>((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              if (value == "College")
                                _categoryId = 0;
                              else if (value == "School")
                                _categoryId = 1;
                              else
                                _categoryId = 2;
                            });
                            if (value == "Other") {
                              setState(() {
                                categorySelected = true;
                                _institutionId = 0;
                              });
                            }
                            if (value != "Other") {
                              getInstitutions(context, value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Select Institution
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      categorySelected && _categoryId != 2
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: SearchableDropdown.single(
                                underline: Center(),
                                readOnly: !categorySelected || _categoryId == 2,
                                items: institutions
                                    .map<DropdownMenuItem<String>>((val) {
                                  return DropdownMenuItem<String>(
                                    value: val.name,
                                    child: Text(
                                      val.name.toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                displayClearIcon: false,
                                hint: 'Select Institution',
                                style: TextStyle(fontSize: 14),
                                icon: Icon(Icons.keyboard_arrow_down),
                                searchHint: 'Enter Institution Name',
                                onChanged: (value) {
                                  _institutionSelected = true;
                                  setState(() {
                                    _institutionName = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            )
                          : Center(),
                    ],
                  ),
                  SizedBox(height: categorySelected ? 25 : 90),
                  // Submit button
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width / 3,
                    buttonColor: primaryColor,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: primaryColor,
                      child: Text("Submit"),
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
