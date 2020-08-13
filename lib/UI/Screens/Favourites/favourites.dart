import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Services/API/favourites_api.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/Favourites/Widgets/favouriteCard.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Favourites"),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: FavouritesAPI.fetchFavourites(),
              builder: (context, snapshot) {
                // If no data
                if (!snapshot.hasData)
                  return Center(
                    child: Text(
                      "Could not fetch favourites",
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                if (snapshot.data == "notLoggedIn")
                  return Center(
                    child: Text(
                      'Not Logged In',
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                // When favourites is empty
                if (snapshot.data.isEmpty) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 3.5),
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
                      return FavouriteCard(
                        event: list[index],
                        refreshFavourites: refreshPage,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
