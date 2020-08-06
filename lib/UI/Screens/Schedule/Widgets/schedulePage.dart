import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/Schedule/Widgets/generateScheduleCardList.dart';

class SchedulePage extends StatelessWidget {
  final scheduleData;
  SchedulePage({@required this.scheduleData});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: Text(
                  "Schedule",
                  style: TextStyle(color: primaryColor),
                ),
                backgroundColor: Colors.white,
                floating: true,
                pinned: true,
                snap: true,
                bottom: new TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 1,
                  indicatorColor: primaryColor,
                  labelColor: primaryColor,
                  tabs: [
                    Tab(
                      text: 'Day 1',
                    ),
                    Tab(
                      text: 'Day 2',
                    ),
                    Tab(
                      text: 'Day 3',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: [
              schedule(1),
              schedule(2),
              schedule(3),
            ],
          ),
        ),
      ),
    );
  }

  Widget schedule(dayNumber) {
    Widget returnWidget;
    if (dayNumber == 1)
      returnWidget = TimeTableList(scheduleData["day1"]);
    else if (dayNumber == 2)
      returnWidget = TimeTableList(scheduleData["day2"]);
    else if (dayNumber == 3) returnWidget = TimeTableList(scheduleData["day3"]);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: returnWidget,
    );
  }
}
