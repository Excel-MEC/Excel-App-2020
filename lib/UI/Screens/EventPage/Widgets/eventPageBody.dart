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
      body: Stack(
        children: <Widget>[
          // TODO: Fix background image
          //Background Image
          getBackgroundImage(
            eventDetails,
            [
              Color.fromRGBO(0, 0, 0, 0),
              Color.fromRGBO(23, 18, 41, .8),
              // primaryColor,
              Color.fromRGBO(0, 0, 0, .8)
            ],
          ),
          Container(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: _minpadding,
                    top: deviceHeight * 0.43,
                  ),
                  child: Row(
                    children: <Widget>[
                      //BackButton
                      IconButton(
                        icon: new Icon(Icons.arrow_back),
                        iconSize: 40.0,
                        color: Colors.white,
                        onPressed: () {
                          // TODO: Fix back button
                          debugPrint("BackButtonPressed");
                        },
                      ),
                      //Event Name Details
                      Expanded(
                        child: Hero(
                          tag: 'EventName',
                          child: Text(
                            eventDetails.name,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: pfontFamily,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Like Button
                      Hero(
                        tag: 'LikeButton',
                        child: Padding(
                          padding: EdgeInsets.all(_minpadding * 2),
                          child: LikeButton(false),
                        ),
                      ),
                    ],
                  ),
                ),

                //Event Details
                getEventDetails(eventDetails, _minpadding),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //Bottom buttons
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width / 2.3,
                      height: 45.0,
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MoreDetails(eventDetails: eventDetails),
                            ),
                          );
                        },
                        borderSide: BorderSide(color: Colors.white),
                        child: Text('More Details'),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width / 2.3,
                      height: 45.0,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('Register'),
                        color: Colors.white,
                        textColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
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
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Container(
                      height: 0
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
