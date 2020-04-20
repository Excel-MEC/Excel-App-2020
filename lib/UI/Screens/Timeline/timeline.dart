import './../../constants.dart';
import 'package:flutter/material.dart';

import './generateTimetableList.dart';

int c = 1;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Map<String, String>> timeTableData = sampleDataDay1;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
            indicatorColor: primaryColor,
            labelColor: primaryColor,
            labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: pfontFamily,
                fontWeight: FontWeight.w600),
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
            'Timeline',
            style: TextStyle(
                fontSize: 19,
                fontFamily: pfontFamily,
                color: Color(0xff282849),
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
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
      returnWidget = TimeTableList(sampleDataDay1);
    else if (dayNumber == 2)
      returnWidget = TimeTableList(sampleDataDay2);
    else if (dayNumber == 3) returnWidget = TimeTableList(sampleDataDay3);
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
