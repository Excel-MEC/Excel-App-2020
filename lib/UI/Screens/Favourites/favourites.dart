import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Favourites"),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                "Swipe to delete",
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("Favourites"),
            ),
          ),
        ],
      ),
    );
  }
}
