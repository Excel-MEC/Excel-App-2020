import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/LandingPage/Widgets/backgroundImage.dart';
import 'package:excelapp/UI/Screens/LandingPage/Widgets/welcomeCard.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:excelapp/UI/Components/Navigation/customNavigation.dart';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _pageController = PageController(initialPage: 0);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          backgroundImage(),
          PageView(
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
              // It redirects to the main page with the bottom navigation bar.
              CustomNavigator()
            ],
            scrollDirection: Axis.vertical,
          )
        ],
      ),
    );
  }
}
