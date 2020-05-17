import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:excelapp/UI/Components/Navigation/customNavigation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CustomNavigator(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            child: Hero(
              tag: 'logo',
              child: Image(
                color: primaryColor,
                image: CachedNetworkImageProvider(
                    'https://avatars1.githubusercontent.com/u/30120883?s=280&v=4'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
