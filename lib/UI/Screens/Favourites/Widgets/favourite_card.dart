import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/Models/favourites_model.dart';
import 'package:excelapp/UI/Screens/EventPage/eventPage.dart';
import 'package:flutter/material.dart';

class FavouriteCard extends StatelessWidget {
  final Favourites favourite;
  FavouriteCard(this.favourite);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Replace hardcoded 1 with event.id , when API is ready
        Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage(favourite.endpoint,favourite.id,favourite.icon)));
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
                imageUrl: favourite.icon,
                // TODO: Placeholder
                placeholder: (context, url) => CircularProgressIndicator(),
              ),
            ),
            title: Text(
              favourite.name[0].toUpperCase() + favourite.name.substring(1),
            ),
            subtitle: Text(
              favourite.dateTime != null ? favourite.dateTime : 'No date | No time',
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