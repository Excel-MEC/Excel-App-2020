import 'package:flutter/material.dart';

import 'Utils/constants.dart';
import 'welcomePage.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'homePage.dart';
import '../../Navigation/customNavigation.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _pageController = firstTime == true
        ? PageController(initialPage: 0)
        : PageController(initialPage: 1);
    //I have set the pageView such that it only shows the user the sponsers when it opens the app
    //a bool variable called firstTime (located in constants.dart) is used for the same

    return Scaffold(
        body: Stack(children: <Widget>[
      backgroundImage(),
      PageView(
        onPageChanged: (_) {
          firstTime = false;
        },
        controller: _pageController,
        children: <Widget>[
          GestureDetector(
            child: WelcomeCard(),
            onTap: () {
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
          ),
          // WillPopScope(child: HomePage(), onWillPop: () => onWillPop())
        CustomNavigator()
        ],
        scrollDirection: Axis.vertical,
      )
    ]));
  }

  Future<bool> onWillPop() async {
    if (_pageController.page == 0) {
      return true;
    } else {
      _pageController.animateToPage(
        0,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 500),
      );
    }
    return false;
  }
}

//The BackgroundImage shown in first Page

backgroundImage() {
  String backgroundImageURL =
      "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80";

  //for gradient overlay
  Color color1 = Color(0x4d09122b);
  Color color2 = Color(0x80111e42);

  return Stack(children: <Widget>[
    Container(
      height: screenSize.height,
      child: CachedNetworkImage(
        imageUrl: backgroundImageURL,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: FractionalOffset.bottomCenter,
        end: FractionalOffset.topCenter,
        colors: [color1, color2],
        stops: [0.0, 1.0],
      )),
    )
  ]);
}
