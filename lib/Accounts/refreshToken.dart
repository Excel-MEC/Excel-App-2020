import 'dart:convert';
import 'package:excelapp/Accounts/account_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> refreshToken() async {
  print("----------\nToken Expired, Retrying\n----------");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String refreshToken = prefs.getString('refreshToken');
  // Refreshing Token
  var refreshResponse = await http.post(
    AccountConfig.url + "Auth/refresh",
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: json.encode({"refreshToken": refreshToken}),
  );
  print(refreshResponse.statusCode);
  if (refreshResponse.statusCode != 200) {
    print("Error fetching/Refreshing Data");
    return null;
  }
  Map<String, dynamic> refreshedBody = json.decode(refreshResponse.body);
  // Taking & Storing JWT & Access token
  String jwt = refreshedBody["accessToken"];
  refreshToken = refreshedBody["refreshToken"];
  prefs.setString('jwt', jwt);
  prefs.setString('refreshToken', refreshToken);
  return jwt;
}
