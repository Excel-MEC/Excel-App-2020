import 'package:excelapp/Accounts/account_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';

class AuthService {
  Future<String> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get access token from Google
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    String accessToken;
    await googleSignIn.signOut();
    GoogleSignInAccount accountInfo = await googleSignIn.signIn();
    GoogleSignInAuthentication googleKeys = await accountInfo.authentication;
    accessToken = googleKeys.accessToken;

    // Store access token locally
    print("Access Token : $accessToken");
    prefs.setString('access_token', accessToken);

    // Send access token to backend -- Recieve jwt
    try {
      Map<String, String> token = {"accessToken": accessToken};
      var response = await http.post(
        AccountConfig.url + 'auth/login/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(token),
      );
      print(json.encode(token));
      print(response.statusCode);
      final Map<String, dynamic> responseData = json.decode(response.body);
      // Store JWT token locally
      String jwt = responseData['token'].toString();
      print("JWT : $jwt");
      prefs.setString('jwt', jwt);

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

    return 'success';
  }
}
