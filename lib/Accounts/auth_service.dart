import 'package:excelapp/Accounts/account_config.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthService {

  Future<String> login() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    AccountConfig config = AccountConfig();
    Auth0 auth0 = Auth0(
      baseUrl: config.baseUrl,
      clientId:config.clientId,
    );

    //Get access token from Auth0
    String accessToken;
    try {
      var response = await auth0.webAuth.authorize({
        'response_type' : 'token',
        'client_id'     : config.clientId,
        'redirect_uri'  : config.redirect,
        'scope'         : 'openid profile email',
      });

      //store access token locally
      accessToken = response['access_token'].toString();
      prefs.setString('access_token', accessToken);
    }
    catch(e) {
      print("Error: $e");
    }


    //send access token to backend -- recieve jwt
    try {
      Map<String, String> token = {"auth_token": accessToken};
      var response = await http.post(
        config.url+'auth/login/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(token),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      //store JWT token locally
      String jwt = responseData['token'].toString();
      prefs.setString('jwt', jwt);

      //User has logged in
      prefs.setBool('isLogged', true);

    }
    catch(e) {
      print("Error: $e");
    }
    return 'success';
  }


  Future<String> fetchUserDetails() async {

    AccountConfig config = AccountConfig();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');

    try {
      var response = await http.get(
      config.url+'profile/',
      headers: config.getHeader(jwt),
      );

      //store user details locally -- details to store can be modified later
      // TODO: Store User in DB
      Map<String,dynamic> responseData = json.decode(response.body);
      await prefs.setString('name', responseData['response']['name']);
      await prefs.setString('email',responseData['response']['email']);
      await prefs.setString('picture', responseData['response']['picture']);

    }catch(e) {
      print("Error: $e");
    }
    return "success";
  }

  Future<String> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //clear access token and jwt
    await prefs.remove('access_token');
    await prefs.remove('jwt');
    await prefs.setBool('isLogged', false);

    return 'success';
  }
  
}