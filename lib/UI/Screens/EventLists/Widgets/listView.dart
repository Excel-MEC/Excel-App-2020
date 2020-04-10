import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/EventLists/Widgets/cards.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/Components/LikeButton/likeButton.dart';

Widget getListView(List<Event> listItems) {
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
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin:
                      EdgeInsets.only(top: 8, bottom: 8, right: 20, left: 20),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(), 
                      cardImage(listItems[index].icon),
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
                                        print(
                                          "Pressed " + listItems[index].name,
                                        );
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
                                              listItems[index].name,
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              listItems[index].dateTime == null
                                                  ? 'null'
                                                  : listItems[index].dateTime ==
                                                      null,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  LikeButton(false),
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
