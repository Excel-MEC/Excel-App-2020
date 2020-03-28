import './Utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Utils/constants.dart';
import 'Utils/models.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  Person user = Person();
  double imageHeight = 150;

  TextEditingController nameController, emailController, phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    user = Person.fromMapObject(userMap);
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 1),
                        qrCode(user.qrUrl),
                        divider(),
                        profilePic(user.imageUrl),
                        SizedBox(width: 1),
                      ],
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 54.0, right: 54.0, top: 0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Info',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: pfontFamily,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _formKey,
                            child: textFields(),
                          ),
                          !_status
                              ? FlatButton(
                                  color: primaryColor,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: sfontFamily),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        _status = true;
                                      });

                                      /*
                                  Function to update data
                                */
                                    }
                                  },
                                )
                              : Container(width: 0, height: 0)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  customAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 24,
        color: primaryColor,
        onPressed: () => Navigator.pop(context),
      ),
      title: new Text('Profile',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: pfontFamily,
              fontSize: 24.0,
              color: primaryColor)),
    );
  }

  profilePic(String url) {
    return Container(
      width: imageHeight,
      height: imageHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primaryColor, width: 6),
        image: new DecorationImage(
          image: new NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            backgroundColor: primaryColor,
            radius: 24.0,
            child: new Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          )),
    );
  }

  divider() {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 24),
      width: 1,
      height: imageHeight,
      color: Colors.grey[300],
    );
  }

  qrCode(String url) {
    return Container(
      width: imageHeight,
      height: imageHeight,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 4),
        image: new DecorationImage(
            image: new NetworkImage(url), fit: BoxFit.contain),
      ),
    );
  }

  textFields() {
    const enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(width: 1, color: primaryColor),
    );
    const border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(20.0),
      ),
    );

    const validatorMessage = 'This field should not be empty';

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (val) => val.isEmpty ? validatorMessage : null,
            onChanged: (val) {
              setState(() => user.name = val);
            },
            controller: nameController,
            decoration: const InputDecoration(
              enabledBorder: enabledBorder,
              border: border,
              labelText: "Name",
              labelStyle: TextStyle(fontFamily: sfontFamily),
            ),
            enabled: !_status,
            autofocus: !_status,
          ),
          Padding(padding: EdgeInsets.all(10)),
          TextFormField(
            validator: (val) => val.isEmpty ? validatorMessage : null,
            onChanged: (val) {
              setState(() => user.email = val);
            },
            controller: emailController,
            decoration: const InputDecoration(
              enabledBorder: enabledBorder,
              border: border,
              labelText: "Email",
              labelStyle: TextStyle(fontFamily: sfontFamily),
            ),
            enabled: !_status,
            autofocus: !_status,
          ),
          Padding(padding: EdgeInsets.all(10)),
          TextFormField(
            validator: (val) => val.isEmpty ? validatorMessage : null,
            onChanged: (val) {
              setState(() => user.phone = val);
            },
            controller: phoneController,
            decoration: const InputDecoration(
              enabledBorder: enabledBorder,
              border: border,
              labelText: "Phone Number",
              labelStyle: TextStyle(fontFamily: sfontFamily),
            ),
            enabled: !_status,
            autofocus: !_status,
          ),
        ],
      ),
    );
  }

  _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: primaryColor,
        radius: 18.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
