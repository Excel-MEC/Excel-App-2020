import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/favourites_api.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final EventDetails eventDetails;
  LikeButton({@required this.eventDetails});
  @override
  State<StatefulWidget> createState() {
    return _LikeButton();
  }
}

class _LikeButton extends State<LikeButton> {
  bool likeState = false;
  bool isLoading = false;
  EventDetails eventDetails;

  handleError(response) {
    print(response);
    if (response == "added")
      setState(() {
        likeState = true;
      });
    else if (response == "deleted")
      setState(() {
        likeState = false;
      });
    else
      alertDialog(text: response, context: context);
  }

  addToFavourites() async {
    setState(() {
      isLoading = true;
    });
    String response =
        await FavouritesAPI.addEventToFavourites(eventDetails: eventDetails);
    handleError(response);
    setState(() {
      isLoading = false;
    });
    // FavouritesStatus.instance.favouritesStatus = 3;
  }

  deleteFromFavourites() async {
    setState(() {
      isLoading = true;
    });
    String response = await FavouritesAPI.deleteFavourite(id: eventDetails.id);
    handleError(response);
    setState(() {
      isLoading = false;
    });
  }

  getFavouritedStatus() async {
    bool isFavourited = await FavouritesAPI.isFavourited(eventDetails.id);
    setState(() {
      likeState = isFavourited;
    });
  }

  @override
  void initState() {
    eventDetails = widget.eventDetails;
    getFavouritedStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: Container(
        color: Colors.white,
        child: isLoading
            ? Container(
                width: 47,
                height: 47,
                padding: const EdgeInsets.all(12.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              )
            : IconButton(
                alignment: Alignment.bottomCenter,
                iconSize: 30,
                color: Colors.grey,
                icon: !likeState
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: () {
                  likeState ? deleteFromFavourites() : addToFavourites();
                  getFavouritedStatus();
                },
              ),
      ),
    );
  }
}
