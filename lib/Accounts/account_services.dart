import 'dart:convert';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:excelapp/Accounts/account_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<String> fetchUserDetails() async {
    User user;
    AccountConfig config = AccountConfig();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');

    try {
      var response = await http.get(
        config.url + 'profile/',
        headers: config.getHeader(jwt),
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

    return "Success";
  }
}
