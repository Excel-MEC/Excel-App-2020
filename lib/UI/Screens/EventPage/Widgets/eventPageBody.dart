import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventDescription.dart';
import 'package:flutter/material.dart';
import 'moreDetailsPage.dart';
import 'backgroundImage.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:excelapp/UI/Components/LikeButton/likeButton.dart';

class EventPageBody extends StatefulWidget {
  final EventDetails eventDetails;
  EventPageBody({this.eventDetails});
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
        fit: StackFit.expand,
        children: <Widget>[
          //Background Image
          getBackgroundImage(
            eventDetails,
            [
              Color.fromRGBO(0, 0, 0, 0),
              Color.fromRGBO(23, 18, 41, .8),
              Color.fromRGBO(0, 0, 0, .8)
            ],
          ),
          // Event Info
          Container(
            child: Column(
              children: <Widget>[
                // Top Area
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Icon
                          Container(
                            height: deviceHeight * 0.2,
                            child: Card(
                              elevation: 8,
                              // TODO: Provide icon from API
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "http://storage.excelmec.org/excel-2019/event-icons/algorithm.png",
                                  placeholder: (context, str) =>
                                      CircularProgressIndicator(),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Bottom Area
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
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

                        //Event Details
                        getEventDetails(eventDetails, _minpadding),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),

                        // Register and Details Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // More Details
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width / 2.3,
                              height: 45.0,
                              child: OutlineButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MoreDetails(
                                        eventDetails: eventDetails,
                                      ),
                                    ),
                                  );
                                },
                                borderSide: BorderSide(color: Colors.white),
                                child: Text('More Details'),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            // Register
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width / 2.3,
                              height: 45.0,
                              child: RaisedButton(
                                onPressed: () {},
                                child: Text('Register'),
                                color: Colors.white,
                                textColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // For Hero Widget
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
                            child: Container(height: 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
