import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Models/favourites_model.dart';
import 'package:excelapp/Services/Database/db_provider.dart';
import 'package:excelapp/UI/Components/LoadingUI/snackBar.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool favo;
  final String icon;
  final String tableName;
  final EventDetails eventDetails;
  LikeButton(this.favo, this.eventDetails, this.icon, this.tableName);
  @override
  State<StatefulWidget> createState() {
    return _LikeButton();
  }
}

class _LikeButton extends State<LikeButton> {
  bool likeState;
  EventDetails _eventDetails;
  String _icon;
  String _tableName;
  DBProvider db;

  @override
  void initState() {
    _icon = widget.icon;
    _tableName = widget.tableName;
    likeState = widget.favo;
    _eventDetails = widget.eventDetails;
    db = DBProvider();
    super.initState();
  }

  Future<dynamic> addToFavourites() async {
    if (likeState == true) {
      print("Like");
      Map<String, dynamic> json = {
        'fav_id': _tableName + _eventDetails.id.toString(),
        'id': _eventDetails.id,
        'name': _eventDetails.name,
        'icon': _icon,
        'date_time': _eventDetails.dateTime,
        'table_name': _tableName
      };

      Favourites favourite = Favourites.fromJson(json);
      print("adding to favourites");
      await db.addFavourites(favourite);
      print("done");

      return "Success";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: Container(
        color: Colors.white,
        child: IconButton(
          alignment: Alignment.bottomCenter,
          iconSize: 30,
          color: Colors.grey,
          icon: !likeState
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite, color: Colors.redAccent),
          onPressed: () {
            // TODO: Add to favourites
            setState(() {
              likeState = !likeState;
            });
            addToFavourites().then((e) {
              if (e == "Success") {
                Scaffold.of(context)
                    .showSnackBar(snackBar("Added to favourites"));
              } else {
                print(likeState);
              }
            });
          },
        ),
      ),
    );
  }
}
