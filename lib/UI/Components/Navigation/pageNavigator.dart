import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/HomePage/homePage.dart';
import 'package:excelapp/UI/Screens/Timeline/timeline.dart';
import 'package:excelapp/UI/Screens/Tests/demoPage.dart';
// import '../UI/Home/profile.dart';
// import '../../Screens/FavouritesPage/favouritesPage.dart';

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
        return Timeline();
        break;
      // case 2:
      //   return FavouritePage();
      //   break;
      case 3:
        return DemoPage();
        break;
      default:
        return Center();
    }
  }
}
