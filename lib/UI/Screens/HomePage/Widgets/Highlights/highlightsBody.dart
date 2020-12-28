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
    if (highLightsMap.length == 0)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
        child: Center(
            child: Text(
          "No Highlights",
          style: TextStyle(color: Colors.black54),
        )),
      );

    return CarouselSlider.builder(
      itemCount: highLightsMap.length,
      viewportFraction: .9,
      height: MediaQuery.of(context).size.width * .9 * (3 / 5),
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
