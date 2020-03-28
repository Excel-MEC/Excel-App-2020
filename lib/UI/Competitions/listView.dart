import 'package:flutter/material.dart';
import 'cards.dart';

Widget getListView(listItems) {
  Widget listview = ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  margin:
                      EdgeInsets.only(top: 8, bottom: 8, right: 20, left: 20),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(),
                      cardImage(listItems[index]["image"]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            PreferredSize(
                              preferredSize: Size.fromWidth(imgCardWidth),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        print("Pressed " +
                                            listItems[index]["name"]);
                                        // Goto Page here
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(30, 0, 5, 0),
                                        // width: 150,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              listItems[index]["name"],
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              listItems[index]["time"],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  LikeButton(),
                                  SizedBox(width: 10),
                                ],
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ]);
      });
  return listview;
}

class LikeButton extends StatefulWidget {
  LikeButton();
  @override
  State<StatefulWidget> createState() {
    return _LikeButton();
  }
}

class _LikeButton extends State<LikeButton> {
  bool likeState;
  @override
  void initState() {
    likeState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.topCenter,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(30),
          //border: Border.all(color: Colors.white, width: 2)
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
            }));
  }
}
