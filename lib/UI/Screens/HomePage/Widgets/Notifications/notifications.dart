import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Notifications/notificationCard.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Notifications"),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 100),
        child: Column(
          children: List.generate(
            notificationData.length,
            (index) => NotificationCard(
              title: notificationData[index]['title'],
              time: notificationData[index]['time'],
              description: notificationData[index]['content'],
            ),
          ),
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
        "* Lorem ipsum dolor sit amet\n* consectetur adipiscing elit\n* sed do eiusmod tempor incididunt ut.\n* labore et dolore magna aliqua.",
  },
  {
    "id": 3,
    "title": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    "time": "2 hours ago",
    "content": "Excel 2020 is ging to be the first tech fest of its kind !"
  }
];
