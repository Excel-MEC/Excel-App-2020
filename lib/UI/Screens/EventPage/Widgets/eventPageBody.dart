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
  final String icon;
  final String tableName;
  EventPageBody({this.eventDetails, this.icon, this.tableName});
  @override
  EventPageBodyState createState() => EventPageBodyState();
}

//Event Details
class EventPageBodyState extends State<EventPageBody> {
  EventDetails eventDetails;
  String _icon;
  String _tableName;
  @override
  void initState() {
    _icon = widget.icon;
    _tableName = widget.tableName;
    eventDetails = widget.eventDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Color textColor = Colors.white;
    return Scaffold(
      backgroundColor: Colors.white,
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
          Column(
            children: <Widget>[
              // Top Area
              SafeArea(
                bottom: false,
                child: Center(),
              ),
              Expanded(
                flex: 2,
                child: Center(),
              ),
              // Icon
              Container(
                height: deviceHeight * 0.2,
                child: Card(
                  elevation: 8,
                  // TODO: Provide icon from API
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: CachedNetworkImage(
                      imageUrl: _icon,
                      placeholder: (context, str) =>
                          CircularProgressIndicator(),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Center(),
              ),

              // Bottom Area
              Row(
                children: <Widget>[
                  IconButton(
                    icon: new Icon(Icons.arrow_back),
                    iconSize: 40.0,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
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
                          fontSize: 35.0,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                  // Like Button
                  Hero(
                    tag: 'LikeButton',
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: LikeButton(false, eventDetails, _icon,_tableName),
                    ),
                  ),
                ],
              ),

              //Event Details
              getEventDetails(eventDetails),
              Expanded(
                flex: 1,
                child: Center(),
              ),

              // Register and Details Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // More Details
                  ButtonTheme(
                    buttonColor: Colors.black,
                    minWidth: deviceWidth / 2.3,
                    height: 45.0,
                    child: RaisedButton(
                      color: Colors.white,
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
                      child: Text('More Details'),
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  // Register
                  ButtonTheme(
                    minWidth: deviceWidth / 2.3,
                    height: 45.0,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('Register'),
                      color: primaryColor,
                      textColor: Colors.white,
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
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(height: 0),
                ),
              ),

              SizedBox(height: 100)
            ],
          ),
        ],
      ),
    );
  }
}
