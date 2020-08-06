import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:excelapp/Services/API/events_api.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Highlights/highlightsBody.dart';

class HighlightsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              "Highlights",
              style: headingStyle,
            ),
          ),
          FutureBuilder(
            future: EventsAPI.fetchHighlights(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return HighlightsBody(highLightsMap: snapshot.data);
              else {
                return Container(
                  child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 4,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
