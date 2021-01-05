import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/Screens/Results/ResultPage/Widgets/processResult.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

class ResultBody extends StatelessWidget {
  final Event event;
  final Map<String, dynamic> resultData;
  ResultBody({this.event, this.resultData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BG 2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 85,
                  child: Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: CachedNetworkImage(
                        imageUrl: event.icon,
                        placeholder: (context, str) =>
                            CircularProgressIndicator(),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: new Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        event.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: pfontFamily,
                          fontSize: 23.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "Results",
              style: TextStyle(
                color: primaryColor,
                fontSize: 17,
                fontFamily: pfontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          ProcessedResult(resultData: resultData),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
