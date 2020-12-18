import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

Widget navDrawer(context, questions, changePage) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close, size: 30),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 10, 10),
            child: Text(
              'Questions',
              style: TextStyle(fontSize: 20, fontFamily: pfontFamily),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    questions.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          changePage(index);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 15, 15),
                              child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(color: primaryColor)),
                                  child: Center(
                                      child: Text(
                                    (index + 10).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ))),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                questions[index]['question'].length > 40
                                    ? questions[index]['question']
                                            .substring(0, 40) +
                                        '.....'
                                    : questions[index]['question'],
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontFamily: pfontFamily,
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.all(18.0),
              child: Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0),
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  'End Test',
                  style: TextStyle(color: Colors.red, fontFamily: pfontFamily),
                )),
              )),
        ],
      ),
    ),
  );
}
