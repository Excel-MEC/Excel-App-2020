import 'package:excelapp/Models/highlights_model.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Highlights/highlight_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HighlightsBody extends StatelessWidget {
  final List<Highlights> highLightsMap;
  HighlightsBody({Key key, @required this.highLightsMap}) : super(key: key);

  final int autoplayseconds = 5;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: highLightsMap.length,
      viewportFraction: 0.9,
      height: MediaQuery.of(context).size.height / 3.5,
      enlargeCenterPage: true,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: autoplayseconds),
      itemBuilder: (BuildContext build, index) {
        return GestureDetector(
          child: HighlightsCard(highLightsMap[index]),
        );
      },
    );
  }
}
