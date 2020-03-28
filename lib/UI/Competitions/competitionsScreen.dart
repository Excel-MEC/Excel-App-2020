import "package:flutter/material.dart";
import 'listView.dart';

String selection = "All";

Color theme = Color.fromRGBO(15, 10, 70, 1);

class Competitions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Excel",
        home: Scaffold(
            appBar: AppBar(
                elevation: 1,
                title: Row(
                  children: <Widget>[
                    Text("Event List",
                        style: TextStyle(
                            color: theme,
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
                    Expanded(child: SizedBox()),
                    IconButton(
                        icon: Icon(Icons.search),
                        color: theme,
                        onPressed: () {/*...*/})
                  ],
                ),
                backgroundColor: Colors.white),
            body: Category()));
  }
}

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Category();
  }
}

class _Category extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            selectionButton('All'),
            SizedBox(width: 10),
            selectionButton('Tech'),
            SizedBox(width: 10),
            selectionButton('Non-Tech'),
          ]),
          SizedBox(height: 10),
          Expanded(
              child: getListView(selection == "All" || selection == "Tech"
                  ? (selection == "Tech" ? tech : compets)
                  : non),)
        ],);
  }

  Widget selectionButton(val) {
    return SizedBox(
        height: 30,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: selection == val ? theme : Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: theme, width: .2)),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  selection = val;
                });
              },
              child: Text(val,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: selection == val ? Colors.white : theme)),
            ),
          ),
        ));
  }
}

var compets = [
  {
    "name": "RoboSoccer",
    "time": "13 November, 11:00AM",
    "image":
        "https://previews.123rf.com/images/alexeitm/alexeitm1806/alexeitm180600002/103288124-classic-football-soccer-ball-on-green-grass-ground-in-front-of-white-goal-with-net.jpg"
  },
  {
    "name": "Algorithms",
    "time": "12 November, 11:00AM",
    "image":
        "https://image.shutterstock.com/image-vector/isometric-young-men-standing-near-260nw-1416555089.jpg"
  },
  {
    "name": "Reverse Coding",
    "time": "11 November 11:00AM",
    "image":
        "https://images.unsplash.com/photo-1515879218367-8466d910aaa4?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9"
  },
  {
    "name": "CEO",
    "time": "12 November, 3:00AM",
    "image":
        "https://www.pngkey.com/png/detail/266-2665205_ceo-ceo-cartoon-png.png"
  },
  {
    "name": "Kryptos",
    "time": "13 November, 3:00AM",
    "image":
        "https://blog.hightail.com/wp-content/uploads/2014/12/HIT_Encrypt_Cryptex.png"
  },
  {
    "name": "Wave Cloning",
    "time": "11 November, 11:00AM",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQZ1kbgQCF2jNIB6MCIqpzl2K5noCi10as_TMdnKhZoZZTIJSpa"
  },
  {
    "name": "Game Zone",
    "time": "13 November, 3:00PM",
    "image":
        "https://www.reviewgeek.com/thumbcache/0/0/485d85e9482be63846f3b7a006e1ef39/p/uploads/2019/07/4a47a0db-16.png"
  },
  {
    "name": "The Khoj",
    "time": "13 November, 3:00AM",
    "image":
        "https://bt-wpstatic.freetls.fastly.net/wp-content/blogs.dir/2207/files/2019/11/treasuremap.jpg.png"
  },
];

var tech = [
  {
    "name": "RoboSoccer",
    "time": "13 November, 11:00AM",
    "image":
        "https://previews.123rf.com/images/alexeitm/alexeitm1806/alexeitm180600002/103288124-classic-football-soccer-ball-on-green-grass-ground-in-front-of-white-goal-with-net.jpg"
  },
  {
    "name": "Algorithms",
    "time": "12 November, 11:00AM",
    "image":
        "https://image.shutterstock.com/image-vector/isometric-young-men-standing-near-260nw-1416555089.jpg"
  },
  {
    "name": "Reverse Coding",
    "time": "11 November, 11:00AM",
    "image":
        "https://images.unsplash.com/photo-1515879218367-8466d910aaa4?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9"
  },
  {
    "name": "Wave Cloning",
    "time": "11 November, 11:00AM",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQZ1kbgQCF2jNIB6MCIqpzl2K5noCi10as_TMdnKhZoZZTIJSpa"
  },
];

var non = [
  {
    "name": "CEO",
    "time": "12 November, 3:00AM",
    "image":
        "https://www.pngkey.com/png/detail/266-2665205_ceo-ceo-cartoon-png.png"
  },
  {
    "name": "Kryptos",
    "time": "13 November, 3:00PM",
    "image":
        "https://blog.hightail.com/wp-content/uploads/2014/12/HIT_Encrypt_Cryptex.png"
  },
  {
    "name": "Game Zone",
    "time": "13 November, 3:00PM",
    "image":
        "https://www.reviewgeek.com/thumbcache/0/0/485d85e9482be63846f3b7a006e1ef39/p/uploads/2019/07/4a47a0db-16.png"
  },
  {
    "name": "The Khoj",
    "time": "13 November, 3:00PM",
    "image":
        "https://bt-wpstatic.freetls.fastly.net/wp-content/blogs.dir/2207/files/2019/11/treasuremap.jpg.png"
  },
];
