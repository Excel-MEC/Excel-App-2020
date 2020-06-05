import 'dart:convert';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class RegistrationStatus {
  static final RegistrationStatus instance = RegistrationStatus.internal();
  RegistrationStatus.internal();
  // 0 if data not retreived, 1 if data retrieved
  int registeredStatus = 0;
  // Stores registered event ID's
  Set<int> registrationIDs = {};
}

class RegistrationAPI {
  // Gets registrationID's of events
  static void fetchRegisteredEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null) {
      RegistrationStatus.instance.registeredStatus = -1;
      return;
    }
    // Fetches data from net & retries if fails
    Future fetchDataFromNet() async {
      http.Response res;
      try {
        res = await http.get(
          APIConfig.baseUrl + '/registration',
          headers: {HttpHeaders.authorizationHeader: "Bearer " + jwt},
        );
        return res;
      } catch (_) {
        await Future.delayed(Duration(milliseconds: 2000), () async {
          res = await fetchDataFromNet();
        });
        return res;
      }
    }

    var response = await fetchDataFromNet();
    try {
      List data = json.decode(response.body);
      RegistrationStatus.instance.registrationIDs = {};
      for (int i = 0; i < data.length; i++) {
        RegistrationStatus.instance.registrationIDs.add(data[i]['id']);
      }
      RegistrationStatus.instance.registeredStatus = 1;
    } catch (_) {
      RegistrationStatus.instance.registeredStatus = 2;
    }
  }

// List to display Registered Events

  static Future<List<Event>> fetchRegistrations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null) return [];
    var response;
    try {
      response = await http.get(
        APIConfig.baseUrl + '/registration',
        headers: {HttpHeaders.authorizationHeader: "Bearer " + jwt},
      );
    } catch (e) {
      print("Error $e");
    }
    List<dynamic> responseData = json.decode(response.body);
    return responseData.map<Event>((event) => Event.fromJson(event)).toList();
  }

// Check if an event is registered
  static isRegistered(id) {
    if (RegistrationStatus.instance.registrationIDs.contains(id)) return true;
    return false;
  }

// Rgisters event

  static Future registerEvent(int id, customAlert, refreshPage, context) async {
    refreshPage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null) {
      customAlert('Not Logged In');
      return;
    }
    if (RegistrationStatus.instance.registeredStatus == 0) {
      customAlert('Cannot Connect');
      return;
    }
    if (isRegistered(id)) {
      customAlert('Already Registered');
      return;
    }
    // Shows Dialog to Confirm, proceeds if Proceed is clicked
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to register ?'),
          content: Text("This cannot be undone."),
          actions: <Widget>[
            FlatButton(
              child: Text("Proceed"),
              // When Proceed is clicked
              onPressed: () async {
                Navigator.of(context).pop();
                // Registers
                try {
                  var a = await http.post(
                    APIConfig.baseUrl + '/registration',
                    headers: {
                      HttpHeaders.authorizationHeader: "Bearer " + jwt,
                      "Content-Type": "application/json"
                    },
                    body: json.encode({"id": id}),
                  );
                  print("Registration over with status code " +
                      a.statusCode.toString());
                  RegistrationStatus.instance.registrationIDs.add(id);
                  refreshPage();
                } catch (_) {
                  customAlert('Registration Failed');
                }
                // End of Registration
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  // End of registerEvent
}
