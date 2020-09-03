import 'dart:convert';
import 'package:excelapp/Accounts/account_config.dart';
import 'package:excelapp/Accounts/getAuthorisedData.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

fetchAmbassadorDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('isLogged') == false || prefs.getBool('isLogged') == null) {
    return 'notLoggedIn';
  } else {
    var user = await HiveDB.retrieveData(valueName: "user");
    return User.fromJson(user);
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
  try {
    var response =
        await getAuthorisedData(AccountConfig.url + 'Ambassador/userlist');
    print(response.body);
    return jsonDecode(response.body);
  } catch (e) {
    print("Error $e");
    return "error";
  }
}
