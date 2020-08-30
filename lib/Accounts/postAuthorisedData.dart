import 'dart:convert';
import 'dart:io';
import 'package:excelapp/Accounts/account_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// The following function Refreshes Access token/JWT
// If it has been expired

postAuthorisedData({String url, body}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString('jwt');
  var response = await http.post(
    url,
    headers: {
      HttpHeaders.authorizationHeader: "Bearer " + jwt,
      "Content-Type": "application/json"
    },
    body: body,
  );
  if (response.statusCode == 455) {
    print("----------\nToken Expired, Retrying\n----------");
    // Getting Refresh Token
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
    jwt = refreshedBody["accessToken"];
    refreshToken = refreshedBody["refreshToken"];
    prefs.setString('jwt', jwt);
    prefs.setString('refreshToken', refreshToken);
    // Retrying Request
    response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + jwt,
        "Content-Type": "application/json"
      },
      body: body,
    );
  }
  if (response.statusCode == 200) return response;
  print("Error fetching Data");
  return null;
}
