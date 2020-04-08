import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventDescription.dart';
import 'package:flutter/material.dart';
import 'moreDetailsPage.dart';
import 'backgroundImage.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:excelapp/UI/Components/LikeButton/likeButton.dart';

class EventPageBody extends StatefulWidget {
  final EventDetails eventDetails;
  EventPageBody({Key key, @required this.eventDetails}) : super(key: key);
  @override
  EventPageBodyState createState() => EventPageBodyState();
}

//Event Details
class EventPageBodyState extends State<EventPageBody> {
  EventDetails eventDetails;

  @override
  void initState() {
    eventDetails = widget.eventDetails;
    super.initState();
  }

  // All paddings made as multiples of _minpadding
  final _minpadding = 5.0;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: <Widget>[
      //Background Image
      getBackgroundImage(eventDetails, [
        Color.fromRGBO(0, 0, 0, 0),
        Color.fromRGBO(23, 18, 41, .8),
        // primaryColor,
        Color.fromRGBO(0, 0, 0, .8)
      ]),
      Container(
          child: ListView(
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(left: _minpadding, top: deviceHeight * 0.43),
              child: Row(
                children: <Widget>[
                  //BackButton
                  IconButton(
                    icon: new Icon(Icons.arrow_back),
                    iconSize: 40.0,
                    color: Colors.white,
                    onPressed: () {
                      debugPrint("BackButtonPressed");
                      Navigator.maybePop(context);
                    },
                  ),

                  //Event Name Details
                  Expanded(
                    child: Hero(
                      tag: 'EventName',
                      child: Text(eventDetails.name,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: pfontFamily,
                              height: 1.0,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ),

                  Hero(
                    tag: 'LikeButton',
                    child: Padding(
                      padding: EdgeInsets.all(_minpadding * 2),
                      child: LikeButton(false),
                    ),
                  ),
                ],
              )),

          //Event Details
          getEventDetails(eventDetails, _minpadding),
          SizedBox(height: deviceHeight * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Bottom buttons
              ButtonTheme(
                minWidth: deviceWidth * 0.4,
                height: _minpadding * 7,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide(color: Colors.white, width: .5)),
                  color: Color.fromRGBO(21, 18, 41, 1),
                  // color: primaryColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(_minpadding * 2),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MoreDetails(eventDetails: eventDetails)),
                    );
                  },
                  child: Text(
                    "More Details",
                    style: TextStyle(
                      fontFamily: sfontFamily,
                      decoration: TextDecoration.none,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: deviceWidth * .4,
                height: _minpadding * 7,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(16.0),
                      side: BorderSide(color: Colors.white, width: .5)),
                  color: Colors.white,
                  textColor: Colors.black,
                  padding: EdgeInsets.all(_minpadding * 2),
                  onPressed: () {},
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontFamily: sfontFamily,
                      decoration: TextDecoration.none,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),

          //Invisible card to utilise hero widget and animate it when more details is clicked
          Hero(
              tag: 'Card',
              child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Container(
                    height: 0,
                  )))
        ],
      ))
    ]));
  }
}
