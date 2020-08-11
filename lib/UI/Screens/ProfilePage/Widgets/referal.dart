import 'dart:convert';

import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/LoginScreen/login_screen.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class AddReferal extends StatefulWidget {
  @override
  _AddReferalState createState() => _AddReferalState();
}

class _AddReferalState extends State<AddReferal> {
  bool loading = false;
  String referal;

  applyReferal() async {
    if (referal == null || referal.length < 4) {
      alertDialog(text: "Enter Valid Referal Code", context: context);
      return;
    }
    setState(() {
      loading = true;
    });
    var response = await AccountServices.addReferalCode(referal);
    print(response);
    // Check response & validate
    // if(response!="success") return
    setState(() {
      loading = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  referal = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Referal Code",
                  hintStyle: TextStyle(fontSize: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
            loading
                ? CircularProgressIndicator()
                : RaisedButton(
                    child: Text("Add referal Code"),
                    onPressed: () {
                      applyReferal();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

Widget referedBy(referer) {
  var refererData = jsonDecode(jsonDecode(referer));
  print(refererData);
  return Container(
    color: Color(0x11000000),
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Row(
      children: [
        Expanded(
          child: Text(
            "Refered by " + refererData["id"].toString(),
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        RaisedButton(
          disabledColor: Colors.grey,
          child: Text("Add referal Code"),
          onPressed: null,
        ),
      ],
    ),
  );
}
