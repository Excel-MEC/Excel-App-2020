import 'dart:convert';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';

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
    var response = await fetchDataFromNet(jwt);
    print('--- Registrations: Network Fetch ---');
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
  static isRegistered(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null)
      return false;
    else if (RegistrationStatus.instance.registrationIDs.contains(id))
      return true;
    else
      return false;
  }

// Recheck if registration possible
  static Future preRegistration({@required int id, @required context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null) {
      return 'Not Logged In';
    }
    if (RegistrationStatus.instance.registeredStatus == 0) {
      return 'Cannot Connect';
    }
    if (await isRegistered(id)) {
      return 'Already Registered';
    }
    return "proceed";
  }

// Registers event
  static Future registerEvent(
      {@required int id, @required refreshFunction, @required context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    try {
      var a = await http.post(
        APIConfig.baseUrl + '/registration',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + jwt,
          "Content-Type": "application/json"
        },
        body: json.encode({"id": id}),
      );
      print("Registration over with status code " + a.statusCode.toString());
      RegistrationStatus.instance.registrationIDs.add(id);
      refreshFunction();
    } catch (_) {
      alertDialog(text: 'Registration Failed', context: context);
    }
  }
}

// Fetches data from net & retries if fails
Future fetchDataFromNet(jwt) async {
  http.Response res;
  try {
    res = await http.get(
      APIConfig.baseUrl + '/registration',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + jwt},
    );
    return res;
  } catch (_) {
    await Future.delayed(Duration(milliseconds: 2000), () async {
      res = await fetchDataFromNet(jwt);
    });
    return res;
  }
}
