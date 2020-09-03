import 'dart:async';
import 'package:excelapp/Services/API/highlights_api.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Highlights/highlightsBody.dart';

class HighlightsSection extends StatefulWidget {
  @override
  _HighlightsSectionState createState() => _HighlightsSectionState();
}

class _HighlightsSectionState extends State<HighlightsSection> {
  StreamController<dynamic> estream;
  bool dataLoaded = false;

  fetchfromNet() async {
    var dataFromNet = await fetchAndStoreHighlightsFromNet();
    if (!dataLoaded || dataFromNet != "error") {
      estream.add(dataFromNet);
      dataLoaded = true;
    }
  }

  initialisePage() async {
    var datafromStorage = await fetchHighlightsFromStorage();
    if (datafromStorage != null) {
      estream.add(datafromStorage);
      dataLoaded = true;
    }
    await fetchfromNet();
  }

  @override
  void initState() {
    estream = StreamController<dynamic>();
    initialisePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
              "Highlights",
              style: headingStyle,
            ),
          ),
          StreamBuilder(
            stream: estream.stream,
            builder: (context, snapshot) {
              // Handle When no data
              if (snapshot.data == "error")
                return Container(
                  color: Color(0xffeeeeee),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("Failed to fetch Highlights"),
                        SizedBox(height: 20),
                        RaisedButton(
                          color: primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            fetchfromNet();
                          },
                          child: Text("Retry"),
                        )
                      ],
                    ),
                  ),
                );
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
