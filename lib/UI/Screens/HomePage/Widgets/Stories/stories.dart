import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:excelapp/UI/Components/Navigation/customNavigation.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Stories/fullPageView.dart';

class Stories extends StatefulWidget {
  @override
  StoriesState createState() => StoriesState();
}

class StoriesState extends State<Stories> {
  int selected = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[SizedBox(width: 10)] +
              List.generate(
                storiesMapList.length,
                (index) => StoryCircle(storiesMapList, index),
              ),
        ),
      ),
    );
  }
}

class StoryCircle extends StatelessWidget {
  final List<Map<String, dynamic>> story;
  final int selectedIndex;
  StoryCircle(this.story, this.selectedIndex);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 7),
          InkWell(
            onTap: () {
              hideBottomNav();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullPageView(
                      storiesMapList: storiesMapList,
                      storyNumber: selectedIndex),
                ),
              ).then((_) => showBottomNav());
            },
            child: CircleAvatar(
              radius: 33,
              backgroundColor: Colors.cyan,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: CachedNetworkImageProvider(
                    story[selectedIndex]['images'][0]),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            story[selectedIndex]['name'],
            style: TextStyle(fontFamily: pfontFamily, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

var storiesMapList = [
  {
    'name': 'First',
    'images': [
      'https://i.pinimg.com/originals/ba/f0/56/baf056ed17e25075de467541c4f9a745.jpg',
      'https://i.pinimg.com/564x/bc/19/d3/bc19d39ffca6afd3d185f9ae00ceb549.jpg',
      'https://i.pinimg.com/564x/8e/7b/b2/8e7bb26427760c5e987c691465f031f9.jpg'
    ]
  },
  {
    'name': 'Second',
    'images': [
      'https://i.pinimg.com/originals/b6/46/15/b64615c7838f17461b43955494206baf.jpg',
      'https://i.pinimg.com/564x/11/e9/23/11e9237fea97d036bb4e7a65217e3303.jpg'
    ]
  },
  {
    'name': 'Third',
    'images': [
      'https://images.unsplash.com/photo-1565378435089-7b0ff45a898e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=730&q=80',
      'https://i.pinimg.com/originals/b6/46/15/b64615c7838f17461b43955494206baf.jpg',
      'https://i.pinimg.com/564x/bc/19/d3/bc19d39ffca6afd3d185f9ae00ceb549.jpg',
      'https://i.pinimg.com/564x/11/e9/23/11e9237fea97d036bb4e7a65217e3303.jpg'
    ]
  },
    {
    'name': 'Fourth',
    'images': [
      'https://i.pinimg.com/originals/ba/f0/56/baf056ed17e25075de467541c4f9a745.jpg',
      'https://i.pinimg.com/564x/bc/19/d3/bc19d39ffca6afd3d185f9ae00ceb549.jpg',
      'https://i.pinimg.com/564x/8e/7b/b2/8e7bb26427760c5e987c691465f031f9.jpg'
    ]
  },
  {
    'name': 'Fifth',
    'images': [
      'https://i.pinimg.com/originals/b6/46/15/b64615c7838f17461b43955494206baf.jpg',
      'https://i.pinimg.com/564x/11/e9/23/11e9237fea97d036bb4e7a65217e3303.jpg'
    ]
  },
  {
    'name': 'Sixth',
    'images': [
      'https://images.unsplash.com/photo-1565378435089-7b0ff45a898e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=730&q=80',
      'https://i.pinimg.com/originals/b6/46/15/b64615c7838f17461b43955494206baf.jpg',
      'https://i.pinimg.com/564x/bc/19/d3/bc19d39ffca6afd3d185f9ae00ceb549.jpg',
      'https://i.pinimg.com/564x/11/e9/23/11e9237fea97d036bb4e7a65217e3303.jpg'
    ]
  }
];
