import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool favo;
  LikeButton(this.favo);
  @override
  State<StatefulWidget> createState() {
    return _LikeButton();
  }
}

class _LikeButton extends State<LikeButton> {
  bool likeState;
  @override
  void initState() {
    likeState = widget.favo;
    super.initState();
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
          },
        ),
      ),
    );
  }
}
