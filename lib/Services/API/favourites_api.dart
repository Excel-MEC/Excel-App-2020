import 'dart:convert';
import 'package:excelapp/Accounts/deleteAuthorisedData.dart';
import 'package:excelapp/Accounts/getAuthorisedData.dart';
import 'package:excelapp/Accounts/postAuthorisedData.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class FavouritesStatus {
  static final FavouritesStatus instance = FavouritesStatus.internal();
  FavouritesStatus.internal();
  // 0 if data not retreived, 1 if data retrieved, 2 if error, 3 if refresh needed, 4 if fetching already
  int favouritesStatus = 0;
  // Stores favourited event ID's
  Set<int> favouritesIDs = {};
  // Event list
  List<Event> eventList = [];

  removeEventFromMemory(int id) {
    for (int i = 0; i < eventList.length; i++) {
      if (eventList[i].id == id) {
        eventList.removeAt(i);
        break;
      }
    }
  }
}

class FavouritesAPI {
  // Gets ID's of favourited events
  static fetchFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null || jwt == "null") {
      FavouritesStatus.instance.favouritesStatus = 3;
      return 'notLoggedIn';
    }

    // Return already fetched Data if loaded.
    if (FavouritesStatus.instance.favouritesStatus == 1)
      return FavouritesStatus.instance.eventList;

    // Returns if already fetching
    if (FavouritesStatus.instance.favouritesStatus == 4) return;

    FavouritesStatus.instance.favouritesStatus = 4;
    var response = await fetchDataFromNet(jwt);
    print('--- Favourites: Fetched from network ---');
    FavouritesStatus.instance.favouritesStatus = 1;

    try {
      if (response.statusCode != 200) return [];
      List data = json.decode(response.body);
      // Add event ID's
      FavouritesStatus.instance.favouritesIDs = {};
      for (int i = 0; i < data.length; i++) {
        FavouritesStatus.instance.favouritesIDs.add(data[i]['id']);
      }
      List<dynamic> responseData = json.decode(response.body);
      FavouritesStatus.instance.eventList =
          responseData.map<Event>((event) => Event.fromJson(event)).toList();
      return FavouritesStatus.instance.eventList;
    } catch (_) {
      FavouritesStatus.instance.favouritesStatus = 2;
      return [];
    }
  }

// Check if an event is favourited
  static isFavourited(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null || jwt == "null")
      return false;
    else if (FavouritesStatus.instance.favouritesIDs.contains(id))
      return true;
    else
      return false;
  }

// Deletes an event from favourites
  static Future deleteFavourite({int id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null || jwt == "null")
      return "Log in to remove favourite events";
    if (FavouritesStatus.instance.favouritesStatus == 0)
      return 'Network not available';
    if (!await isFavourited(id)) return "Already Unfavourited";
    try {
      var response = await deleteAuthorisedData(
        APIConfig.baseUrl + '/bookmark/' + id.toString(),
      );
      print("Removing from favourites attempted with status code " +
          response.statusCode.toString());

      if (response.statusCode != 200) return "An error occured";
      FavouritesStatus.instance.favouritesIDs.remove(id);
      FavouritesStatus.instance.removeEventFromMemory(id);
      // Can instead use FavouritesStatus.instance.favouritesStatus = 3;
      return "deleted";
    } catch (_) {
      return "An error occured";
    }
  }

// Add event to favourites
  static Future addEventToFavourites(
      {@required EventDetails eventDetails}) async {
    int id = eventDetails.id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    if (jwt == null || jwt == "null")
      return "Log in to add favourite events";
    else if (FavouritesStatus.instance.favouritesStatus == 0)
      return "Network not Aailable";
    else if (await isFavourited(id)) return "Already in Favourites";
    try {
      var response = await postAuthorisedData(
        url: APIConfig.baseUrl + '/bookmark',
        body: json.encode({"eventId": id}),
      );
      print("Adding to favourites attempted with status code " +
          response.statusCode.toString());
      if (response.statusCode != 200) return "An error occured";
      FavouritesStatus.instance.favouritesIDs.add(id);
      // Converts event details model to event model to add to favourites
      Event eventDetailsToEvent = Event.fromJson(eventDetails.toJson());
      FavouritesStatus.instance.eventList.add(eventDetailsToEvent);
      // Can instead use FavouritesStatus.instance.favouritesStatus = 3;
      return "added";
    } catch (_) {
      return "An error occured";
    }
  }
  // End of registerEvent

}

Future fetchDataFromNet(jwt) async {
  var res;
  try {
    res = await getAuthorisedData(APIConfig.baseUrl + '/bookmark');
    return res;
  } catch (_) {
    await Future.delayed(Duration(milliseconds: 3000), () async {
      res = await fetchDataFromNet(jwt);
    });
    return res;
  }
}
