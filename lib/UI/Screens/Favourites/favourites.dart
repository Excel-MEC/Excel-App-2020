import 'package:excelapp/Models/favourites_model.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Screens/Favourites/Widgets/favourite_card.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  DBProvider db;
  
  @override
  void initState() { 
    db = DBProvider();
    super.initState();
  }

  Future<List<Favourites>> fetchFavourites() async {
    print("fetching all favourites from db");
    List<Favourites> favourites = await db.getFavourites();
    return favourites;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Favourites"),
      body: FutureBuilder(
        future: fetchFavourites(),
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List<Favourites> list = snapshot.data;
            if(list.isEmpty) {
              return Center(child: Text("No Favorites"));
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return FavouriteCard(list[index]);
              },
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}