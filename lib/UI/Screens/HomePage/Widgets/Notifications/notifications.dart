import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Notifications"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[SizedBox(height: 5)] +
              List.generate(
                notificationData.length,
                (index) => Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.notifications, color: Colors.grey),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    notificationData[index]['title'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    notificationData[index]["time"],
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 11.5,
                                    ),
                                  ),
                                  Divider(height: 10),
                                  Text(
                                    notificationData[index]['content'],
                                    style: TextStyle(
                                      color: Color(0x99000000),
                                      fontSize: 12.5,
                                      fontFamily: pfontFamily,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ) +
              [SizedBox(height: 95)],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> notificationData = [
  {
    "id": 1,
    "title": "Interesting fact!",
    "time": "Just now",
    "content":
        "Excel 2020 is called excel 2020 because it happend in the year 2020 and also because it happens after Excel 2019"
  },
  {
    "id": 2,
    "title": "Second notification",
    "time": "5 mins ago",
    "content":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  },
  {
    "id": 3,
    "title": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    "time": "2 hours ago",
    "content": "Excel 2020 is ging to be the first tech fest of its kind !"
  }
];
