import 'dart:async';
import 'dart:convert';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/UI/Components/Appbar/darkAppbar.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/backgroundImage.dart';
import 'package:excelapp/UI/Screens/Results/ResultPage/Widgets/resultBody.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  final Event event;
  ResultPage({@required this.event});
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future resultDetails;

  @override
  void initState() {
    super.initState();
    resultDetails = fetchResultDetails();
  }

  fetchResultDetails() async {
    print("- Result of " + widget.event.id.toString() + " network fetch");
    try {
      var response = await http.get(
          APIConfig.baseUrl + "/Result/event/" + widget.event.id.toString());
      if (response.statusCode != 200) return "error";
      var responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      print("Error $e");
      return ("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: darkAppbar(),
      body: FutureBuilder(
        future: resultDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "error") {
              return errorRetry();
            }
            return ResultBody(resultData: snapshot.data, event: widget.event);
          } else {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //Background Image
                getBackgroundImage(
                  [
                    Color.fromRGBO(0, 0, 0, 0),
                    Color.fromRGBO(23, 18, 41, .8),
                    Color.fromRGBO(0, 0, 0, .8)
                  ],
                ),
                LoadingAnimation(color: Colors.white)
              ],
            );
          }
        },
      ),
    );
  }

  Widget errorRetry() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Failed to load result",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30),
          RaisedButton(
            color: primaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(event: widget.event),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
