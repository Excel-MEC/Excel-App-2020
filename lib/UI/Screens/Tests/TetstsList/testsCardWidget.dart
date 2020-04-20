import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

double imgCardWidth = 275, cardHeight=105;

Widget testCard(var listItems,int index){
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
                                        print("Pressed "+listItems[index]["name"]);
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
                                            Text("${listItems[index]["round"]}",
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
                                  Container(width: 1.4, color: Colors.white, height: 56),
                                  SizedBox(width: 20,),
                          Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("${listItems[index]["date"]}",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                          Divider(color: Colors.white, thickness: 2, height: 7),
                          Text("${listItems[index]["time"]}",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300)),
                        ]),
                                  SizedBox(width: 20),
                                ],
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ]);
}

Stack cardImage(String url) {
  Color gradientcolor1 = primaryColor;
  Color gradientcolor2 = primaryColor;
  BorderRadius roundness = BorderRadius.circular(16);
  return Stack(children: <Widget>[
    Opacity(
        opacity: 1,
        child: Container(
            //width:imgCardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(url),
                ),
                borderRadius: BorderRadius.all(
                  const Radius.circular(20.0),
                )))),
    //gradient overlay
    Opacity(
        opacity: 0.88,
        child: Container(
          //width: imgCardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
              borderRadius: roundness,
              gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [gradientcolor1, gradientcolor2],
                stops: [0.0, 1.0],
              )),
        ))
  ]);
}