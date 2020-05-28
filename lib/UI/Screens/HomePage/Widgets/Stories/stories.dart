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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[SizedBox(width: 10)] +
            List.generate(
              storiesMapList.length,
              (index) => StoryCircle(storiesMapList[index], index),
            ),
      ),
    );
  }
}

class StoryCircle extends StatelessWidget {
  final Map<String, dynamic> story;
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
                      selectedIndex: selectedIndex),
                ),
              ).then((_) => showBottomNav());
            },
            child: Hero(
              tag: 'story' + selectedIndex.toString(),
              child: CircleAvatar(
                radius: 33,
                backgroundColor: Colors.cyan,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: CachedNetworkImageProvider(story['image']),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            story['name'],
            style: TextStyle(fontFamily: pfontFamily, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> storiesMapList = [
  {
    'id': 0,
    'name': 'First',
    'image':
        'https://images.pexels.com/photos/1156684/pexels-photo-1156684.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
  },
  {
    'id': 1,
    'name': 'Second',
    'image':
        'https://i.pinimg.com/originals/75/46/c5/7546c5153850a7c1b674e9deaea4a445.jpg'
  },
  {
    'id': 2,
    'name': 'Third',
    'image':
        'https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
  },
  {
    'id': 3,
    'name': 'Fourth',
    'image':
        'https://i.pinimg.com/originals/b6/46/15/b64615c7838f17461b43955494206baf.jpg'
  },
  {
    'id': 4,
    'name': 'Fifth',
    'image':
        'https://cdn.statically.io/img/www.itl.cat/pngfile/big/14-144281_cool-phone-backgrounds-dark-cool-phone-backgrounds.jpg'
  }
];
