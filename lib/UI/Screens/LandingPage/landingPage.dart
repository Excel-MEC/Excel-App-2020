import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:excelapp/UI/Components/Navigation/customNavigation.dart';
import 'package:excelapp/UI/Screens/LandingPage/Widgets/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      key: introKey,
      pages: [
        PageViewModel(
          bodyWidget: introPage(),
          title: "",
        ),
        PageViewModel(
          decoration: PageDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 0)),
          bodyWidget: page(
              "Our Motto",
              "Inspire  |  Innovate  |  Engineer\n\nInnovation drives the modern day world. Excel has been inspiring youth to innovate and bring out the best engineers in them !",
              "assets/introScreen/page2.png",
              context),
          title: "",
        ),
        PageViewModel(
          decoration: PageDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 0)),
          bodyWidget: page(
              "Come Join Us",
              "Certain events wake us, nurture us and revitalize us. But how often do these events come? Either you wait for those moments or you create them. Sometimes life offers you a chance to take yourself to the next level. All you have to do is to seize them.",
              "assets/introScreen/page3.png",
              context),
          title: "",
        ),
        PageViewModel(
          decoration: PageDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 0)),
          bodyWidget: lastPage(context),
          title: "",
        ),
      ],
      onDone: () => onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor)),
      next: Icon(Icons.arrow_forward, color: primaryColor),
      done: Text(''),
      dotsDecorator: DotsDecorator(
        activeColor: primaryColor,
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
    );
  }
}

void onIntroEnd(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('firstTime', false);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => CustomNavigator()),
  );
}
