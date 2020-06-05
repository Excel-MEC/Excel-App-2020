import 'dart:convert';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventPageBody.dart';

class RegistrationStatus {
  static final RegistrationStatus instance = RegistrationStatus.internal();
  RegistrationStatus.internal();
  // 0 if data not retreived, 1 if data retrieved
  int registeredStatus = 0;
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
      RegistrationStatus.instance.registeredStatus=1;
    } catch (_) {
      RegistrationStatus.instance.registeredStatus = 2;
    }
  }

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

  static isRegistered(id) {
    if (RegistrationStatus.instance.registrationIDs.contains(id)) return true;
    return false;
  }


// Rgisters event

  static Future registerEvent(int id, customAlert, refreshPage) async {
    refreshPage();
    if (RegistrationStatus.instance.registeredStatus == 0) {
      customAlert('Check Net Connection');
      return;
    }
    if (isRegistered(id)) {
      customAlert('Already Registered');
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null) {
      customAlert('Not Logged In');
    }
    try {
      var a = await http.post(
        APIConfig.baseUrl + '/registration',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + jwt,
          "Content-Type": "application/json"
        },
        body: json.encode({"id": id}),
      );
      RegistrationStatus.instance.registrationIDs.add(id);
      refreshPage();
    } catch (_) {
      customAlert('Registration Failed');
    }
  }
}
