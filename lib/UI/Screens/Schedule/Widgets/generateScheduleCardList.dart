import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/schedule_model.dart';
import 'package:excelapp/UI/Screens/EventPage/eventPage.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class TimeTableList extends StatelessWidget {
  final eventDetails;

  TimeTableList(this.eventDetails);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[Padding(padding: EdgeInsets.all(8))] +
          List.generate(
            eventDetails.length,
            (i) => ScheduleEvent(eventDetails[i], i, eventDetails.length),
          ) +
          [
            eventDetails.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                        child: Text(
                      "No Events",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    )),
                  )
                : Center(),
            SizedBox(
              height: 90,
            )
          ],
    );
  }
}

class ScheduleEvent extends StatelessWidget {
  final ScheduleModel eventSchedule;
  final int lineNumber;
  final int eventLength;

  ScheduleEvent(this.eventSchedule, this.lineNumber, this.eventLength);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        lineAndDot(lineNumber, eventLength),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventPage(eventSchedule.id),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: ListTile(
                dense: true,
                isThreeLine: true,
                title: Text(eventSchedule.name ?? ""),
                leading: CachedNetworkImage(
                  imageUrl: eventSchedule.icon,
                  width: 40,
                  height: 40,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(eventSchedule.round ?? ""),
                    SizedBox(height: 3),
                    Text(
                      ScheduleDateTimeConversion.dateTimeToString(
                            eventSchedule.datetime,
                          ) ??
                          "",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget lineAndDot(lineNumber, noOfEvents) {
  noOfEvents = noOfEvents - 1;
  double rowHeight = 95.0;
  double left = 25;
  double circleRadius = 4.5;
  double width = left * 2 - 10;
  double top = 42;
  return Stack(
    children: <Widget>[
      Container(
        width: width,
      ),
      Container(
        margin: lineNumber != 0
            ? (lineNumber == noOfEvents
                ? EdgeInsets.only(left: left, bottom: rowHeight / 2)
                : EdgeInsets.only(left: left))
            : EdgeInsets.only(left: left, top: rowHeight / 2),
        width: 1.0,
        height: lineNumber != 0
            ? lineNumber == noOfEvents
                ? rowHeight / 2
                : rowHeight
            : rowHeight / 2,
        color: noOfEvents == 0 ? Colors.transparent : primaryColor,
      ),
      Container(
        margin: EdgeInsets.only(left: left - circleRadius, top: top),
        child: CircleAvatar(
          backgroundColor: primaryColor,
          radius: circleRadius,
        ),
      )
    ],
  );
}
