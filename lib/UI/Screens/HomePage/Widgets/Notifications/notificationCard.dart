import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String time;
  NotificationCard({this.id, this.title, this.time, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        title,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 11.5,
                        ),
                      ),
                      Divider(height: 10),
                      Text(
                        description,
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
    );
  }
}
