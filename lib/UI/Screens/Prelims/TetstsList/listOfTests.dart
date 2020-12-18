//import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import './resultsCardWidget.dart';
import './testsCardWidget.dart';

double imgCardWidth = 275, cardHeight = 105;

class ListOfTests extends StatefulWidget {
  @override
  _ListOfTests createState() => _ListOfTests();
}

class _ListOfTests extends State<ListOfTests> {
  var tests;

  List notStarted = List<Widget>();
  List inProgress = List<Widget>();
  List results = List<Widget>();

  @override
  void initState() {
    super.initState();

    var listItems = test;
    for (int index = 0; index < 6; index++) {
      if (test[index]["status"] == "Not Started")
        notStarted.add(testCard(listItems, index));
      else
        inProgress.add(testCard(listItems, index));
    }

    for (int index = 0; index < 6; index++) {
      results.add(resultCard(listItems, index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Tests Page",
            style: TextStyle(color: primaryColor),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
            indicatorColor: primaryColor,
            labelColor: primaryColor,
            labelStyle: TextStyle(fontSize: 20),
            tabs: [
              Tab(
                text: 'Tests',
              ),
              Tab(
                text: 'Results',
              ),
            ],
          ),
        ),
        body: Container(
            child: TabBarView(children: [
          ListView(
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 27, top: 13, bottom: 13),
                          child: Text(
                            "Not Started",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 24,
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ] +
                      notStarted),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        Padding(
                            padding:
                                EdgeInsets.only(left: 27, top: 13, bottom: 13),
                            child: Text("In Progress",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700)))
                      ] +
                      inProgress),
            ],
          ),
          ListView(
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      <Widget>[Padding(padding: EdgeInsets.all(12))] + results)
            ],
          )
        ])),
      ),
    );
  }
}

var test = [
  {
    "name": "Algorithms",
    "time": "11:00am",
    "date": "12 Nov",
    "status": "Not Started",
    "round": "Round 2",
    "image":
        "https://image.shutterstock.com/image-vector/isometric-young-men-standing-near-260nw-1416555089.jpg"
  },
  {
    "name": "Codeathon",
    "time": "11:00am",
    "date": "11 Nov",
    "status": "In Progress",
    "round": "Prelims",
    "image":
        "https://images.unsplash.com/photo-1515879218367-8466d910aaa4?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9"
  },
  {
    "name": "DataBull",
    "time": "3:00am",
    "date": "12 Nov",
    "status": "In Progress",
    "round": "Finals",
    "image":
        "https://www.pngkey.com/png/detail/266-2665205_ceo-ceo-cartoon-png.png"
  },
  {
    "name": "Kryptos",
    "time": "3:00am",
    "date": "13 Nov",
    "status": "Not Started",
    "round": "Prelims",
    "image":
        "https://blog.hightail.com/wp-content/uploads/2014/12/HIT_Encrypt_Cryptex.png"
  },
  {
    "name": "Wave Cloning",
    "time": "11:00am",
    "date": "11 Nov",
    "status": "In Progress",
    "round": "Prelims",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQZ1kbgQCF2jNIB6MCIqpzl2K5noCi10as_TMdnKhZoZZTIJSpa"
  },
  {
    "name": "Game Zone",
    "time": "3:00am",
    "date": "13 Nov",
    "status": "In Progress",
    "round": "Prelims",
    "image":
        "https://www.reviewgeek.com/thumbcache/0/0/485d85e9482be63846f3b7a006e1ef39/p/uploads/2019/07/4a47a0db-16.png"
  },
  {
    "name": "The Khoj",
    "time": "3:00am",
    "date": "13 Nov",
    "status": "Not Started",
    "round": "Prelims",
    "image":
        "https://bt-wpstatic.freetls.fastly.net/wp-content/blogs.dir/2207/files/2019/11/treasuremap.jpg.png"
  },
];
