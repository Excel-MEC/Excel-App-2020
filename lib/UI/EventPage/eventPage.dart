import './eventDescription.dart';
import 'package:flutter/material.dart';
import 'moreDetailsPage.dart';
import 'backgroundImage.dart';

Map<String, String> eventDetails = {
  'ImageDir':
      'https://images.unsplash.com/photo-1584918652568-c9ec7152a482?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=669&q=80',
  'Name': 'Kryptos',
  'Time': '12th November 2019 | 12pm -2pm',
  'Venue': 'Room No.301-304',
  'Contact': '+91 90642658845',
  'Fee': '₹100',
  'About':
      'Excel 2019 presents Treasure Hunt , a union of mutiple diverse rounds designed to test the skills of contestants. Be it a quest around Kochi, make campus or perhaps even around Kochi, make sure you are prepared! Get ready to accomplishdifferent tasks to be declared the winner. Spread over two days , the event is guarenteed to push you to your limts',
  'Format': 'This is the format of the event',
  'Rules': 'This is the rules of the event',
  'Contacts': 'This is the contact details of the event',
  'isLiked': 'false'
};

class EventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventPageState();
  }
}

//Event Details
class EventPageState extends State<EventPage> {
  //All paddings made as multiples of _minpadding
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
        Color.fromRGBO(0, 0, 0, .8)
      ]),
      Container(
          child: ListView(
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(left: _minpadding, top: deviceHeight * 0.38),
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

                  Hero(
                    tag: 'LikeButton',
                    child: Padding(
                      padding: EdgeInsets.all(_minpadding * 2),
                      child: likeButton(eventDetails['isLiked']),
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
                      fontFamily: fontLight,
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
                    "Book Tickets",
                    style: TextStyle(
                      fontFamily: fontLight,
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
