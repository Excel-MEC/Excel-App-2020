import '../Home/Utils/constants.dart';
import 'package:flutter/material.dart';
import './generateTimetableList.dart';

int c = 1;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Map<String, String>> timeTableData = sampleDataDay1;
  String daynumber = '01';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SafeArea(child: Center()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Timeline',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: pfontFamily,
                                color: Color(0xff282849),
                                fontWeight: FontWeight.w600),
                          ),
                          // Text(
                          //   daynumber,
                          //   style: TextStyle(
                          //       fontSize: 20,
                          //       color: Color(0xff282849),
                          //       fontWeight: FontWeight.w300),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTableData = sampleDataDay1;
                              daynumber = '01';
                            });
                          },
                          child: _day('01'),
                        ),
                        SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTableData = sampleDataDay2;
                              daynumber = '02';
                            });
                          },
                          child: _day('02'),
                        ),
                        SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTableData = sampleDataDay3;
                              daynumber = '03';
                            });
                          },
                          child: _day('03'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              TimeTableList(timeTableData)
            ],
          ),
        ),
      ),
    );
  }

  Widget _day(dayno) {
    return Transform.scale(
      child: Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 22, 15, 22),
            child: Column(
              children: <Widget>[
                Text(
                  'Day',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: pfontFamily,
                      fontSize: 15),
                ),
                Text(
                  dayno,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          elevation: dayno == daynumber ? 5 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          )),
      scale: dayno == daynumber ? 1.15 : 1,
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
