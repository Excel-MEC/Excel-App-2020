import 'dart:convert';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnregisterAllEvents extends StatelessWidget {
  unregister(context) async {
    var user = await HiveDB.retrieveData(valueName: "user");
    User userData = User.fromJson(user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    final request = http.Request("DELETE",
        Uri.parse("https://staging.events.excelmec.org/api/registration"));
    request.headers.addAll(<String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer $jwt',
    });
    request.body = jsonEncode({"excelId": userData.id});
    final response = await request.send();
    if (response.statusCode == 200)
      alertDialog(text: "Success", context: context);
    else
      alertDialog(
          text: "Failed. " + response.statusCode.toString(), context: context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        unregister(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Text(
          "  Delete all registrations\n(admin only, will be removed)",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
