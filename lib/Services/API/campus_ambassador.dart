import 'dart:convert';
import 'package:excelapp/Accounts/account_config.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

fetchAmbassadorDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString('jwt');
  if (jwt == null) return "notLoggedIn";
  try {
    var response = await http.get(
      AccountConfig.url + 'Ambassador',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + jwt},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 500) return "joinProgram";
    return jsonDecode(response.body);
  } catch (e) {
    print("Error $e");
    return "error";
  }
}

joinAmbassadorProgram() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString('jwt');
  try {
    var response = await http.get(
      AccountConfig.url + 'Ambassador/signup',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + jwt},
    );
    print(response.statusCode);
    if (response.body == "") return "error";
    return jsonDecode(response.body);
  } catch (e) {
    print("Error $e");
    return "error";
  }
}

getReferalList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString('jwt');
  try {
    var response = await http.get(
      AccountConfig.url + 'Ambassador/userlist',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + jwt},
    );
    print(response.body);
    return jsonDecode(response.body);
  } catch (e) {
    print("Error $e");
    return "error";
  }
}
