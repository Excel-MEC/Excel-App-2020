import 'package:excelapp/Accounts/account_config.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthService {

  Future<String> login() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Auth0 auth0 = Auth0(
      baseUrl: AccountConfig.baseUrl,
      clientId: AccountConfig.clientId,
    );

    //Get access token from Auth0
    String accessToken;
    try {
      var response = await auth0.webAuth.authorize({
        'response_type' : 'token',
        'client_id'     : AccountConfig.clientId,
        'redirect_uri'  : AccountConfig.redirect,
        'scope'         : 'openid profile email',
      });

      //store access token locally
      accessToken = response['access_token'].toString();
      print("Access Token : $accessToken");
      prefs.setString('access_token', accessToken);
    }
    catch(e) {
      print("Error: $e");
    } 


    //send access token to backend -- recieve jwt
    try {
      Map<String, String> token = {"auth_token": accessToken};
      var response = await http.post(
        AccountConfig.url+'auth/login/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(token),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      //store JWT token locally
      String jwt = responseData['token'].toString();
      print("JWT : $jwt");
      prefs.setString('jwt', jwt);

      //User has logged in
      prefs.setBool('isLogged', true);

    }
    catch(e) {
      print("Error: $e");
    }
    return 'success';
  }



  Future<String> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //clear access token and jwt
    await prefs.remove('access_token');
    await prefs.remove('jwt');
    await prefs.setBool('isProfileUpdated', false);
    await prefs.setBool('isLogged', false);

    return 'success';
  }
  
}