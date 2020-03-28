import './backgroundImage.dart';
import './eventDescription.dart';
import 'package:flutter/material.dart';

String fontBold = 'Quicksand-Bold';
String fontLight = 'Quciksand-Light';

class MoreDetails extends StatefulWidget {
  final eventDetails;
  MoreDetails({Key key, @required this.eventDetails}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MoreDetailsState(eventDetails);
  }
}

class MoreDetailsState extends State<MoreDetails> {
  var eventDetails;
  MoreDetailsState(this.eventDetails);
  //Stores the current active tab in more details
  String activeTab = 'About';

  //All paddings made as multiples of _minpadding
  double _minpadding = 5.0;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: <Widget>[
      // Background Image
      getBackgroundImage(eventDetails, [
        Color.fromRGBO(0, 0, 0, 1),
        Color.fromRGBO(23, 18, 41, 0.8),
        Color.fromRGBO(0, 0, 0, .6)
      ]),

      Container(
          child: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: _minpadding * 7, top: deviceHeight * 0.15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Event Name Details
                  Expanded(
                    child: Hero(
                      tag: 'EventName',
                      child: Text(eventDetails['Name'],
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: fontBold,
                              height: 1.0,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ),

                  //Like Button
                  Hero(
                    tag: 'LikeButton',

                    //Code to make the button under a Material widget during animation which otherwise throws error
                    flightShuttleBuilder: (BuildContext flightContext,
                            Animation<double> animation,
                            HeroFlightDirection flightDirection,
                            BuildContext fromHeroContext,
                            BuildContext toHeroContext) =>
                        Material(
                            type: MaterialType.transparency,
                            child: toHeroContext.widget),
                    child: Padding(
                      padding: EdgeInsets.all(_minpadding),
                      child: likeButton(eventDetails['isLiked']),
                    ),
                  ),
                ],
              )),

          //EventDetails
          getEventDetails(eventDetails, _minpadding),

          SizedBox(height: _minpadding * 2),

          // More details card
          Container(
              height: deviceHeight * .57,
              padding: EdgeInsets.only(top: _minpadding),
              child: Hero(
                  tag: 'Card',
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45))),
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  //Tabs in the More Details section
                                  getTab('About', activeTab),
                                  getTab('Format', activeTab),
                                  getTab('Rules', activeTab),
                                  getTab('Contacts', activeTab),
                                ]),
                          ),
                          Column(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    top: _minpadding * 3,
                                    left: _minpadding * 6,
                                    right: _minpadding * 6,
                                    bottom: _minpadding * 3),
                                child: Text(
                                  eventDetails[activeTab],
                                  style: TextStyle(
                                    fontFamily: fontLight,
                                    color: Color.fromRGBO(23, 18, 41, 1),
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )),
                          ])
                        ],
                      ))))),
        ],
      )),
    ]));
  }

//More details tab styling
  Widget getTab(String tabName, String active) {
    bool isClicked = active == tabName;
    return Padding(
      // padding: EdgeInsets.all(_minpadding),
      padding: EdgeInsets.all(0),
      child: ButtonTheme(
        minWidth: _minpadding * 5,
        height: _minpadding * 8,
        child: FlatButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(17.0),
                side: BorderSide(color: Colors.transparent)),
            color: Colors.transparent,
            padding: EdgeInsets.all(_minpadding * 2),
            onPressed: () {
              setState(() {
                activeTab = tabName;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1.0,
                            color: isClicked
                                ? Color.fromRGBO(21, 18, 41, 1)
                                : Colors.transparent))),
                child: getTabText(tabName, isClicked))),
      ),
    );
  }

  //More details tab text styling
  Widget getTabText(String text, bool isClicked) {
    if (isClicked)
      return Text(text,
          style: TextStyle(
              height: 1.0,
              fontSize: 21.0,
              fontFamily: fontBold,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(23, 18, 41, 1)));
    else
      return Text(text,
          style: TextStyle(
              height: 1.0,
              fontSize: 18.0,
              fontFamily: fontLight,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(23, 18, 41, 0.4)));
  }

  //Like button functionality
  Widget likeButton(String isLiked) {
    bool likeState = isLiked == 'true';
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(0x99ffffff), width: 1)),
        child: IconButton(
            iconSize: 32,
            color: Colors.white,
            icon: !likeState
                ? Icon(Icons.favorite_border)
                : Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              //Insert function that enables this event as favourite
              /*

                        Over Here

                    */
              setState(() {
                likeState = !likeState;
                eventDetails['isLiked'] = '$likeState';
              });
            }));
  }
}
