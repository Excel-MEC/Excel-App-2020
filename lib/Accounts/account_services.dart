import 'dart:convert';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:excelapp/Accounts/account_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  // Fetch user details right after authentication
  static Future<String> fetchUserDetails() async {
    User user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');

    try {
      var response = await http.get(
        AccountConfig.url + 'profile/',
        headers: AccountConfig.getHeader(jwt),
      );

      // Store User in DB
      Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      user = User.fromJson(responseData);
      print("adding to database");
      DBProvider dbProvider = DBProvider();
      await dbProvider.addUser(user, 'User');
      print("done");

      // Store user id in shared preference
      await prefs.setInt('userId', user.id);
    } catch (e) {
      print("Error: $e");
    }

    return "success";
  }

  // View user profile
  static Future<User> viewProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    User user;
    
    try {
      print("fetching user details");
      var response = await http.get(
        AccountConfig.url + 'profile/view',
        headers: AccountConfig.getHeader(jwt),
      );
      Map<String,dynamic> responseData = json.decode(response.body);
      user = User.fromJson(responseData);
      print("adding to database");
      DBProvider dbProvider = DBProvider();
      await dbProvider.addUser(user, 'User');
      print("done");
      return user;
    } catch (e) {}
  }

  // Fetch list of institutions
  static Future<List<Institution>> fetchInstitutions(String category) async {
    if (category == "professional") {
      return [];
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');

    try {
      print("fetching institutions");
      var response = await http.get(
        AccountConfig.url + 'institution/$category/list',
        headers: AccountConfig.getHeader(jwt),
      );
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map<Institution>((institution) => Institution.fromJson(institution))
          .toList();
    } catch (e) {
      print("Error: $e");
    }
  }

  // Update User Profile
  static Future<String> updateProfile(Map<String, dynamic> userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');

    try {
      var response = await http.post(
        AccountConfig.url + 'profile/update',
        headers: AccountConfig.getHeader(jwt),
        body: json.encode(userInfo),
      );
      print(response.body);
    } catch (e) {
      print("Error: $e");
    }
    return "done";
  }
}
