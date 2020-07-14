import 'package:excelapp/Services/API/favourites_api.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int id;
  LikeButton({@required this.id});
  @override
  State<StatefulWidget> createState() {
    return _LikeButton();
  }
}

class _LikeButton extends State<LikeButton> {
  bool likeState = false;
  bool isLoading = false;
  int eventID;

  handleError(response) {
    print(response);
    if (response == "notLoggedin")
      alertDialog(text: 'Log in to favourite events', context: context);
    else if (response == "networkNotaAailable")
      alertDialog(text: 'Network not available', context: context);
    else if (response == "existing")
      alertDialog(text: 'Network not available', context: context);
    else if (response == "error")
      alertDialog(text: 'An error occured', context: context);
    else if (response == "added")
      setState(() {
        likeState = true;
      });
    else if (response == "deleted")
      setState(() {
        likeState = false;
      });
  }

  addToFavourites() async {
    setState(() {
      isLoading = true;
    });
    String response = await FavouritesAPI.addEventToFavourites(id: eventID);
    handleError(response);
    setState(() {
      isLoading = false;
    });
    FavouritesStatus.instance.favouritesStatus = 3;
  }

  deleteFromFavourites() async {
    setState(() {
      isLoading = true;
    });
    String response = await FavouritesAPI.deleteFavourite(eventID);
    handleError(response);
    setState(() {
      isLoading = false;
    });
    FavouritesStatus.instance.favouritesStatus = 3;
  }

  getFavouritedStatus() async {
    bool isFavourited = await FavouritesAPI.isFavourited(eventID);
    setState(() {
      likeState = isFavourited;
    });
  }

  @override
  void initState() {
    eventID = widget.id;
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
                },
              ),
      ),
    );
  }
}
