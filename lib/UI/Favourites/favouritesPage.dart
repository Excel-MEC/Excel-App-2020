import 'package:cached_network_image/cached_network_image.dart';

import '../Home/Utils/constants.dart';
import '../Home/Utils/data.dart';
import '../Home/Utils/models.dart';
import 'package:flutter/material.dart';
import './registeredPage.dart';

class FavouritePage extends StatefulWidget {
  @override
  FavouritePageState createState() => FavouritePageState();
}

class FavouritePageState extends State<FavouritePage> {
  var favEvents;
  var isLiked;

  final double cardHeight = 160;
  final double cardRoundness = 24;
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
      fontSize: 15,
      fontWeight: FontWeight.w500);

  @override
  void initState() {
    super.initState();
    favEvents = List<Event>();
    for (int i = 0; i < highLightsMap.length; i++) {
      favEvents.add(Event.fromMapObject(highLightsMap[i]));
    }
    print("Favourite: ${favEvents.length}");
    isLiked = [true, true, true];
    favListBuilder();
  }


  Widget schedule(index) {
    List<Widget> returnWidget;
    if(index==0) returnWidget= favListBuilder();
    else if(index==1) returnWidget=[RegisteredPage()];
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
              <Widget>[Padding(padding: EdgeInsets.all(12))] + returnWidget,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
            indicatorColor: primaryColor,
            labelColor: Color(0xff252a50),
            labelStyle: TextStyle(fontSize: 20),
            tabs: [
              Tab(
                text: 'Favourites',
              ),
              Tab(
                text: 'Registered',
              ),
            ],
          ),
          title: Text(
            'Excel 2020',
            style: TextStyle(color: primaryColor),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: TabBarView(
            children: [
              schedule(0),
              schedule(1),
            ],
          ),
        ),
      ),
    );
  }

  favListBuilder() {
    var favListWidget = List<Widget>();
    for (int i = 0; i < favEvents.length; i++) {
      favListWidget.add(GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          height: cardHeight,
          child: Card(
              margin: EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(cardRoundness)),
              child: Stack(
                children: <Widget>[
                  cardImage(favEvents[i].imageUrl),
                  highLightCardContent(favEvents[i], i)
                ],
              )),
        ),
        onTap: () {
          //Insert Function
          print("U tapped ${favEvents[i].eventName}");
        },
      ));
    }

    return favListWidget;
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
                  borderRadius: BorderRadius.circular(cardRoundness),
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
}
