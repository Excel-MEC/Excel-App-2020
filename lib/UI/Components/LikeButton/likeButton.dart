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
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: IconButton(
          color: Colors.white,
          icon: !likeState ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
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
