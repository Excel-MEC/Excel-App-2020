import 'package:excelapp/UI/Screens/HomePage/Widgets/Highlights/highlight_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:excelapp/Models/event_card.dart';

class HighLights extends StatefulWidget {
  final List<Event> highLightsMap;

  HighLights({Key key, @required this.highLightsMap}) : super(key: key);
  @override
  HighLightsState createState() => HighLightsState();
}

class HighLightsState extends State<HighLights> {
  int autoplayseconds = 5;
  var isLiked;

  // TODO: Move to Constants
  var titleStyle = TextStyle(
    color: Colors.white,
    fontFamily: pfontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  var contentStyle = TextStyle(
    color: Colors.white,
    fontFamily: sfontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  List<Event> highLightsMap;

  @override
  void initState() {
    super.initState();
    highLightsMap = widget.highLightsMap;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: highLightsMap.length,
      height: MediaQuery.of(context).size.height/3,
      viewportFraction: 0.9,
      enlargeCenterPage: true,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: autoplayseconds),
      itemBuilder: (BuildContext build, index) {
        return GestureDetector(
          child: HighlightsCard(highLightsMap[index]),
          // TODO: Navigate to details page
          onTap: () {},
        );
      },
    );
  }
}
