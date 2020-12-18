import 'package:excelapp/UI/Screens/HomePage/Widgets/Highlights/highlights.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/home_appBar.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Categories/categories.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/socialIcons.dart';
// import 'package:excelapp/UI/Screens/HomePage/Widgets/Stories/stories.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Drawer/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(context),
      drawer: CustomDrawer(),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              // Stories(),
              HighlightsSection(),
              Categories(),
              SocialIcons(),
              SizedBox(height: MediaQuery.of(context).size.height / 6)
            ],
          ),
        ),
      ),
    );
  }
}
