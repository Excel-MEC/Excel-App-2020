import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/Screens/EventPage/eventPage.dart';
import 'package:flutter/material.dart';


class EventCard extends StatelessWidget {
  final Event event;
  final String endpoint;
  EventCard(this.event,this.endpoint);

  @override 
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Replace hardcoded 1 with event.id , when API is ready
        Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage(endpoint,event.id)));
      }, 
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              child: CachedNetworkImage(
                imageUrl: event.icon,
                // TODO: Placeholder
                placeholder: (context, url) => CircularProgressIndicator(),
              ),
            ),
            title: Text(
              event.name,
            ),
            subtitle: Text(
              event.datetime != null ? event.datetime : 'No date | No time',
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }
}
