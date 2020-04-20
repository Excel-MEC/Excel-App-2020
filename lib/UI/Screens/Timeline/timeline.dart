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
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            indicatorColor: primaryColor,
            labelColor: Color(0xff252a50),
            labelStyle: TextStyle(
                fontSize: 15,
                fontFamily: pfontFamily,
                color: Color(0xff282849),
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
                fontSize: 20,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            <Widget>[Padding(padding: EdgeInsets.all(8))] + [returnWidget],
      ),
    );
  }
}

List<Map<String, String>> sampleDataDay1 = [
  {
    'name': 'Robosoccer Day 1',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Khoj',
    'content': '10AM - 4PM | Amphitheatre',
    'image': 'https://wallpapercave.com/wp/pZPTMMO.jpg'
  },
  {
    'name': 'Reverse Coding',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Next Event',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Robosoccer Day 1',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Khoj',
    'content': '10AM - 4PM | Amphitheatre',
    'image': 'https://wallpapercave.com/wp/pZPTMMO.jpg'
  },
  {
    'name': 'Robosoccer Day 1',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Khoj',
    'content': '10AM - 4PM | Amphitheatre',
    'image': 'https://wallpapercave.com/wp/pZPTMMO.jpg'
  },
];
List<Map<String, String>> sampleDataDay2 = [
  {
    'name': 'Day 2 Soccer',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Khoj Day 2',
    'content': '10AM - 4PM | Amphitheatre',
    'image': 'https://wallpapercave.com/wp/pZPTMMO.jpg'
  },
  {
    'name': 'Reverse Coding',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Next Event',
    'content': 'Amphitheatre\n10AM - 4PM',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
];
List<Map<String, String>> sampleDataDay3 = [
  {
    'name': 'Robosoccer Day3',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Khoj',
    'content': '10AM - 4PM | Amphitheatre',
    'image': 'https://wallpapercave.com/wp/pZPTMMO.jpg'
  },
  {
    'name': 'Reverse Coding',
    'content': '10AM - 4PM | Amphitheatre',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
  {
    'name': 'Next Event',
    'content': 'Amphitheatre\n10AM - 4PM',
    'image':
        'https://free4kwallpapers.com/uploads/wallpaper/neon-retro-computers-by-lorenzo-herrera-wallpaper-1024x768-wallpaper.jpg'
  },
];
