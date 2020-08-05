import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/Schedule/Widgets/generateScheduleCardList.dart';

class SchedulePage extends StatelessWidget {
  final scheduleData;
  SchedulePage({@required this.scheduleData});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            indicatorColor: primaryColor,
            labelColor: primaryColor,
            labelStyle: TextStyle(
              fontSize: 14,
              fontFamily: pfontFamily,
              fontWeight: FontWeight.w600,
            ),
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
          title: Text(
            'Schedule',
            style: TextStyle(
              fontSize: 20,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          child: TabBarView(
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

List<Map<String, String>> sampleDataDay1 = [
  {
    'name': 'Robosoccer Day 1',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Khoj',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/algorithm.png'
  },
  {
    'name': 'Reverse Coding',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Next Event',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Robosoccer Day 1',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Khoj',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'https://wallpapercave.com/wp/pZPTMMO.jpg'
  },
  {
    'name': 'Robosoccer Day 1',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Khoj',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'https://wallpapercave.com/wp/pZPTMMO.jpg'
  },
];
List<Map<String, String>> sampleDataDay2 = [
  {
    'name': 'Day 2 Soccer',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Khoj Day 2',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/algorithm.png'
  },
  {
    'name': 'Reverse Coding',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Next Event',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
];
List<Map<String, String>> sampleDataDay3 = [
  {
    'name': 'Robosoccer Day3',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Khoj',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'https://wallpapercave.com/wp/pZPTMMO.jpg'
  },
  {
    'name': 'Reverse Coding',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
  {
    'name': 'Next Event',
    'time': '10AM - 4PM',
    'venue': 'Amphitheatre',
    'image': 'http://storage.excelmec.org/excel-2019/event-icons/debug.png'
  },
];
