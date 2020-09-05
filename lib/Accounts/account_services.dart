import 'dart:convert';
import 'package:excelapp/Accounts/getAuthorisedData.dart';
import 'package:excelapp/Accounts/postAuthorisedData.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
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
      await HiveDB.storeData(valueName: "user", value: user.toJson());
      print("done");

      // Store user id in shared preference
      await prefs.setInt('userId', user.id);

      // Check if user has updated profile
      if (user.category == "Not Registered") {
        await prefs.setBool('isProfileUpdated', false);
      } else {
        await prefs.setBool('isProfileUpdated', true);
      }
    } catch (e) {
      print("Error: $e");
    }

    return "success";
  }

  // View user profile
  static viewProfile() async {
    User user;

    try {
      print("fetching user details");
      var response =
          await getAuthorisedData(AccountConfig.url + 'profile/view');
      if (response.statusCode != 200) return null;
      Map<String, dynamic> responseData = json.decode(response.body);
      user = User.fromJson(responseData);
      return user;
    } catch (e) {
      print("Error : $e");
      return null;
    }
  }

  // Fetch list of institutions
  static fetchInstitutions(String category) async {
    if (category == "Other") {
      return [];
    }

    try {
      print("fetching institutions");
      var response = await getAuthorisedData(
        AccountConfig.url + 'institution/$category/list',
      );
      List<dynamic> responseData = json.decode(response.body);
      // print(responseData);
      return responseData
          .map<Institution>((institution) => Institution.fromJson(institution))
          .toList();
    } catch (e) {
      return "error";
    }
  }

  // Update User Profile
  static Future<String> updateProfile(Map<String, dynamic> userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    User user;

    try {
      var response = await postAuthorisedData(
        url: AccountConfig.url + 'profile/update',
        body: json.encode(userInfo),
      );
      if (response.statusCode != 200 && response.statusCode != 422)
        return "error";
      print(response.body);
    } catch (e) {
      print("Error $e");
      return "error";
    }

    // Update shared preferences
    prefs.setBool('isProfileUpdated', true);
    // Update user database
    try {
      print("fetching user details");
      var response = await http.get(
        AccountConfig.url + 'profile',
        headers: AccountConfig.getHeader(jwt),
      );
      Map<String, dynamic> responseData = json.decode(response.body);
      user = User.fromJson(responseData);
      print("adding to database");
      await HiveDB.storeData(valueName: "user", value: user.toJson());
      print("done");
    } catch (e) {
      print("Error : $e");
    }
    return "done";
  }

// Used to add referal code to account(Only possible once for an account)
  static addReferalCode(referalCode) async {
    try {
      var response = await postAuthorisedData(
        url: AccountConfig.url + 'Ambassador/referral',
        body: json.encode({"referralCode": referalCode}),
      );
      if (response.statusCode == 500) return "error";
      if (response.statusCode == 404) return "invalid";
      print(response.body);
      print("Referal Status code: " + response.statusCode.toString());
    } catch (e) {
      print("Error $e");
      return "error";
    }
  }
}
