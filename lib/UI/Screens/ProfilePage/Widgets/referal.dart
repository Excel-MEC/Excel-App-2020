import 'dart:convert';
import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
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
    // If we get error
    if (response == "error" || response == "invalid") {
      if (response == "error")
        alertDialog(
          text: "Something went wrong. Try again",
          context: context,
        );
      else if (response == "invalid")
        alertDialog(
          text: "Invalid referal code",
          context: context,
        );
      setState(() {
        loading = false;
      });
      return;
    }
    print(response);
    var refetchDetails = await AccountServices.fetchUserDetails();

    setState(() {
      loading = false;
    });
    if (refetchDetails == "success")
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CheckUserLoggedIn(),
        ),
      );
    // else show error
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
                ? LoadingAnimation()
                : RaisedButton(
                    color: Color(0xfff5f5f5),
                    elevation: 1,
                    child: Text(
                      "Add Referal Code",
                      style: TextStyle(color: primaryColor),
                    ),
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
  var refererData = jsonDecode(referer);
  if (refererData == null) return Container();
  return Container(
    color: Color(0x11000077),
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
          disabledColor: Color(0x0a000000),
          child: Text("Add referal Code"),
          onPressed: null,
        ),
      ],
    ),
  );
}
