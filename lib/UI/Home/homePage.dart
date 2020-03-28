import './profile.dart';

import 'Utils/models.dart';

import 'Utils/constants.dart';
import 'Utils/data.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          homeTitle(context),
          //
          Container(height: 100),
          Padding(padding: EdgeInsets.only(bottom: 16)),
          //
          HighLights(),
          Categories()
        ],
      ),
    );
  }

  homeTitle(BuildContext context) {
    double fontSize = 28;
    var fontWeight = FontWeight.w700;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Excel 2020",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: primaryColor,
                fontFamily: pfontFamily,
              )),
          headingIcons(context)
        ],
      ),
    );
  }

  headingIcons(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.person_outline),
          iconSize: 30,
          color: primaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications_none),
          iconSize: 28,
          color: primaryColor,
          onPressed: () {},
        )
      ],
    );
  }

  customAppBar() {
    return PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(0));
  }
}

//HighLights Part of Home Page
class HighLights extends StatefulWidget {
  @override
  HighLightsState createState() => HighLightsState();
}

class HighLightsState extends State<HighLights> {
  List<Event> highLightEvents;
  int autoplayseconds = 5;
  double carousalHeight = 240;
  var isLiked;
  var titleStyle = TextStyle(
      color: Colors.white,
      fontFamily: pfontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w600);
  var contentStyle = TextStyle(
      color: Colors.white,
      fontFamily: sfontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400);

  @override
  void initState() {
    super.initState();
    highLightEvents = List<Event>();
    for (int i = 0; i < highLightsMap.length; i++) {
      highLightEvents.add(Event.fromMapObject(highLightsMap[i]));
    }
    print("HighLights: ${highLightEvents.length}");
    isLiked = [false, false, false];
  }

  //Testing Like Feature

  //Testing Like Feature

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: highLightEvents.length,
        height: carousalHeight,
        viewportFraction: 0.9,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: autoplayseconds),
        itemBuilder: (BuildContext build, index) {
          return GestureDetector(
            child: Card(
                margin: EdgeInsets.all(4),
                child: Stack(
                  children: <Widget>[
                    cardImage(highLightEvents[index].imageUrl),
                    highLightCardContent(highLightEvents[index], index)
                  ],
                )),
            onTap: () {
              //Insert Function
              print("U tapped ${highLightEvents[index].eventName}");
            },
          );
        });
  }

  highLightCardContent(Event event, int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                event.eventName,
                style: titleStyle,
              ),
              Text("${event.date} | ${event.time}", style: contentStyle)
            ],
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 2)),
              child: IconButton(
                  iconSize: 32,
                  color: Colors.white,
                  icon: !isLiked[index]
                      ? Icon(Icons.favorite_border)
                      : Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    //Insert function that enables this event as favourite
                    /*

                        Over Here

                    */
                    setState(() {
                      isLiked[index] = !isLiked[index];
                    });
                  }))
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final headingStyle = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 24, fontFamily: pfontFamily);
  final titleStyle = TextStyle(
      color: Colors.white,
      fontFamily: pfontFamily,
      fontSize: 26,
      fontWeight: FontWeight.w600);
  final contentStyle = TextStyle(
      color: Colors.white,
      fontFamily: sfontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(28, 28, 28, 14),
              child: Text(
                "Categories",
                style: headingStyle,
              )),
          categoryCard(0, context),
          categoryCard(1, context),
          categoryCard(2, context),
          categoryCard(3, context),
        ]);
  }

  categoryCard(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
          height: 160,
          child: GestureDetector(
            child: Card(
                margin: EdgeInsets.all(4),
                child: Stack(children: <Widget>[
                  cardImage(categoriesMap[index]["imageUrl"]),
                  categoryCardContent(categoriesMap[index], context)
                ])),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => fakePage()));
            },
          )),
    );
  }

  categoryCardContent(Map<String, dynamic> map, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                map["name"],
                style: titleStyle,
              ),
              Container(
                width: 240,
                child: Text(
                  map["info"],
                  style: contentStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              )
            ],
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 2)),
              child: Icon(
                Icons.navigate_next,
                size: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Functions common to both
cardImage(String url) {
  var gradientcolor1 = Color(0xf224234A);
  var gradientcolor2 = Color(0xb324234A);
  var roundness = BorderRadius.circular(16);
  return Stack(children: <Widget>[
    CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            borderRadius: roundness,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      ),
    ),

    //gradient overlay
    Container(
      decoration: BoxDecoration(
          borderRadius: roundness,
          gradient: LinearGradient(
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            colors: [gradientcolor1, gradientcolor2],
            stops: [0.0, 1.0],
          )),
    )
  ]);
}

Widget fakePage() {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      leading: BackButton(),
    ),
  );
}
