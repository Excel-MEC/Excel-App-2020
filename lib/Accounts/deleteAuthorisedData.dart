import 'dart:io';
import 'package:excelapp/Accounts/refreshToken.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// The following function Refreshes Access token/JWT
// If it has been expired

deleteAuthorisedData(String url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString('jwt');
  var response = await http.delete(
    url,
    headers: {
      HttpHeaders.authorizationHeader: "Bearer " + jwt,
      "Content-Type": "application/json"
    },
  );
  // If token has expired, rfresh it
  if (response.statusCode == 455 || response.statusCode == 500) {
    // Refreshes Token & gets JWT
    jwt = await refreshToken();
    if (jwt == null) return null;

    // Retrying Request
    response = await http.delete(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + jwt,
        "Content-Type": "application/json"
      },
    );
  }
  return response;
}
