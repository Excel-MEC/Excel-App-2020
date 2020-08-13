import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/Screens/EventPage/eventPage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteCard extends StatelessWidget {
  final Event event;
  final Function refreshFavourites;
  FavouriteCard({this.event, this.refreshFavourites});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventPage(event.id),
          ),
        ).then((_) => refreshFavourites());
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: ListTile(
            dense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              child: CachedNetworkImage(
                imageUrl: event.icon,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    child: CircleAvatar(backgroundColor: Colors.white),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                  );
                },
              ),
            ),
            title: Text(
              event.name,
            ),
            subtitle: Text(
              event.datetime != null
                  ? DateTimeConversion.dateTimeToString(event.datetime)
                  : 'No date | No time',
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
