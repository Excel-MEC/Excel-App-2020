import 'dart:convert';
import 'dart:io';

import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/API/favourites_api.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/EventCard/event_card.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Favourites"),
      body: FutureBuilder(
        future: FavouritesAPI.fetchFavourites(),
        builder: (context, snapshot) {
          // If no data
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          if (snapshot.data == "notLoggedIn")
            return Center(
              child: Text('Not Logged In'),
            );
          // When favourites is empty
          if (snapshot.data.isEmpty) {
            return Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 3.5),
                  Icon(
                    Icons.favorite,
                    size: 60,
                    color: primaryColor,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "No Favourites yet",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            );
          } else {
            // When favourites is not empty
            List<Event> list = snapshot.data;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return EventCard(list[index]);
              },
            );
          }
        },
      ),
    );
  }
}
