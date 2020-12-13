import 'package:excelapp/Accounts/account_config.dart';
import 'package:excelapp/Accounts/refreshToken.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// The following function Refreshes Access token/JWT
// If it has been expired

getAuthorisedData(String url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString('jwt');

  // print(jwt);
  var response = await http.get(
    url,
    headers: AccountConfig.getHeader(jwt),
  );
  // If token has expired, refresh it
  if (response.statusCode == 455 || response.statusCode == 500) {
    // Refreshes Token & gets JWT
    jwt = await refreshToken();
    if (jwt == null) return null;

    // Retrying Request
    response = await http.get(
      url,
      headers: AccountConfig.getHeader(jwt),
    );
  }
  return response;
}
