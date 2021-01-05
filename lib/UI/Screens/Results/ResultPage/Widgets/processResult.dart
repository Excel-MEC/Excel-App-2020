import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class ProcessedResult extends StatelessWidget {
  final Map<String, dynamic> resultData;
  ProcessedResult({this.resultData});

// Data for reference
  final sampleData = [
    {
      "isTeam": true,
      "results": [
        {
          "id": 0,
          "eventId": 0,
          "excelId": 0,
          "teamId": 0,
          "event": {
            //So much content here
          },
          "position": 0,
          "name": "string",
          "teamName": "string",
          "teamMembers": "string"
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> res = resultData["results"];
    res.sort((a, b) => a["position"].compareTo(b["position"]));

// If team event
    if (resultData["isTeam"] == true)
      return Column(
        children: List.generate(
          res.length,
          (index) => Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 5),
            child: ListTile(
              dense: true,
              leading: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 18,
                child: Text(
                  res[index]["position"].toString(),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              title: Text("Team " + res[index]["teamName"]),
              // Team members
              subtitle: Text("Members: " + res[index]["teamMembers"]),
            ),
          ),
        ),
      );

// If not team event
    return Column(
      children: List.generate(
        res.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 5),
          child: ListTile(
            dense: true,
            leading: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 18,
              child: Text(
                res[index]["position"].toString(),
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            title: Text(res[index]["name"]),
            subtitle: Text("Excel ID: " + res[index]["excelId"].toString()),
          ),
        ),
      ),
    );
  }
}
