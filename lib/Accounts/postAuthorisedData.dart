import 'dart:io';
import 'package:excelapp/Accounts/refreshToken.dart';
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
  // If token has expired, rfresh it
  if (response.statusCode == 455) {
    // Refreshes Token & gets JWT
    jwt = await refreshToken();
    if (jwt == null) return null;
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
