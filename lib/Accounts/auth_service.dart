import 'package:excelapp/Accounts/account_config.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';

class AuthService {
  Future<String> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken;
    // Get access token from Google
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      await googleSignIn.signOut();
      GoogleSignInAccount accountInfo = await googleSignIn.signIn();
      GoogleSignInAuthentication googleKeys = await accountInfo.authentication;
      accessToken = googleKeys.accessToken;
    } catch (err) {
      print("Error: $err");
    }

    // Store access token locally
    print("Google Access Token : $accessToken");
    prefs.setString('access_token', accessToken);

    // Send access token to backend -- Recieve jwt
    try {
      print(AccountConfig.url + 'auth/login/');
      Map<String, String> token = {"accessToken": accessToken};
      var response = await http.post(
        AccountConfig.url + 'auth/login/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(token),
      );
      print(json.encode(token));
      print(response.statusCode);
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      // Store JWT token locally
      String jwt = responseData['accessToken'].toString();
      String refreshToken = responseData['refreshToken'].toString();
      print("JWT : $jwt");
      print("\nRefresh Token : $refreshToken");
      prefs.setString('jwt', jwt);
      prefs.setString('refreshToken', refreshToken);

      // User has logged in
      prefs.setBool('isLogged', true);
    } catch (e) {
      print("Error: $e");
    }
    return 'success';
  }

  Future<String> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear access token and jwt
    await prefs.remove('access_token');
    await prefs.remove('jwt');
    await prefs.setBool('isProfileUpdated', false);
    await prefs.setBool('isLogged', false);
    await HiveDB.storeData(valueName: "user", value: null);

    return 'success';
  }
}
