import 'dart:convert';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationStatus {
  static final RegistrationStatus instance = RegistrationStatus.internal();
  RegistrationStatus.internal();
  // 0 if data not retreived, 1 if data retrieved, -1 if not logged in, 2 error
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
}
