import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

Widget pageBody(questionDetails, Map<String, String> answers, var updateAnswer,
    var nextQuestion, var prevQuestion) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1583324113626-70df0f4deaab?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
              fit: BoxFit.fill,
              height: 120.0,
              width: 200.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Text(
            questionDetails['question'],
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: pfontFamily),
          ),
        ),
        Column(
          children: List.generate(
            questionDetails['options'].length,
            (index) {
              return RaisedButton(
                color: answers[questionDetails['id']] == index.toString()
                    ? primaryColor
                    : Colors.white,
                onPressed: () {
                  updateAnswer(questionDetails['id'], index.toString());
                },
                child: Container(
                  width: 200,
                  child: Center(
                    child: Text(
                      questionDetails['options'][index.toString()],
                      style: TextStyle(
                        fontFamily: pfontFamily,
                        color:
                            answers[questionDetails['id']] == index.toString()
                                ? Colors.white
                                : primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                prevQuestion();
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xFF00008B))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back, size: 15),
                    ),
                    Text(
                      'Previous',
                      style: TextStyle(
                          color: primaryColor, fontFamily: pfontFamily),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                nextQuestion();
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFF00002E),
                  border: Border.all(
                    color: Color(0xFF00008B),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 8.0),
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white, fontFamily: pfontFamily),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
