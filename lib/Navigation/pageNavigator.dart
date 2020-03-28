import 'package:flutter/material.dart';
import '../UI/Home/homePage.dart';
import '../UI/Timeline/timeline.dart';
import '../UI/Home/profile.dart';
import '../UI/Favourites/favouritesPage.dart';

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
      case 2:
        return FavouritePage();
        break;
      case 3:
        return ProfilePage();
        break;
      default:
        return Center();
    }
  }
}
