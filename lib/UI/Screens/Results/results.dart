import 'dart:async';
import 'dart:convert';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Screens/Results/resultCard.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:http/http.dart' as http;

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Future results;

  @override
  void initState() {
    super.initState();
    results = fetchResults();
  }

  Future fetchResults() async {
    print("- Results network fetch");
    try {
      var response = await http.get(APIConfig.baseUrl + "/events/results_out");
      if (response.statusCode != 200) return "error";
      var responseData = json.decode(response.body);
      return responseData.map<Event>((event) => Event.fromJson(event)).toList();
    } catch (e) {
      print("Error $e");
      return ("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Results"),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: results,
              builder: (context, snapshot) {
                // return Text(snapshot.data.toString());
                // If no internet & not stored
                if (snapshot.data == "error")
                  return Center(
                    child: Text(
                      "Failed to load. Please retry",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  );
                List<Event> list = snapshot.data;
                // If data is present
                if (snapshot.hasData) {
                  // If no events
                  if (list.isEmpty)
                    return Center(
                      child: Text(
                        "No Events",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    );

                  return ListView(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: <Widget>[
                          SizedBox(height: 20),
                        ] +
                        List.generate(
                          list.length,
                          (index) {
                            return ResultCard(
                              list[index],
                            );
                          },
                        ) +
                        <Widget>[
                          SizedBox(height: 60),
                        ],
                  );
                } else {
                  return LoadingAnimation();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
