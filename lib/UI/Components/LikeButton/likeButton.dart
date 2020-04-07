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
      alignment: AlignmentDirectional.topCenter,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
          iconSize: 25,
          color: Colors.white,
          icon: !likeState
              ? Icon(Icons.favorite_border)
              : Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            //Insert function that enables this event as favourite
            /*
                        Over Here
                    */
            setState(() {
              likeState = !likeState;
            });
          }),
    );
  }
}