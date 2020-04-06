import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Utils/data.dart';

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
        ),
      ),
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
