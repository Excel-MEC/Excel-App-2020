import 'package:excelapp/UI/Screens/Favourites/favourites.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/HomePage/homePage.dart';
import 'package:excelapp/UI/Screens/ProfilePage/profile_main.dart';
import 'package:excelapp/UI/Screens/Schedule/schedule.dart';

class NavigatingPage extends StatelessWidget {
  NavigatingPage({this.pageNumber});
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    switch (pageNumber) {
      case 0:
        return HomePage();
        break;
      case 1:
        return Schedule();
        break;
      case 2:
        return FavouritesScreen();
        break;
      case 3:
        return CheckUserLoggedIn();
        break;
      default:
        return Center();
    }
  }
}
