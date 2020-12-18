import 'package:excelapp/UI/Screens/Prelims/TestPage/navDrawer.dart';
import 'package:excelapp/UI/Screens/Prelims/TestPage/pageBody.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

class TestPage extends StatefulWidget {
  static final String id = 'My_home';

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String appbarText = 'Question 1';
  int selectedQuestion = 0;
  changePage(index) {
    setState(() {
      selectedQuestion = index;
      appbarText = 'Question ' + (index + 1).toString();
    });
  }

  updateAnswer(index, id) {
    setState(() {
      answers.update(
        index.toString(),
        (_) => id,
        ifAbsent: () => id,
      );
      print(answers);
    });
  }

  nextQuestion() {
    if (selectedQuestion < questions.length - 1) {
      setState(() {
        selectedQuestion = selectedQuestion + 1;
        appbarText = 'Question ' + (selectedQuestion + 1).toString();
      });
    }
  }

  prevQuestion() {
    if (selectedQuestion > 0) {
      setState(() {
        selectedQuestion = selectedQuestion - 1;
        appbarText = 'Question ' + (selectedQuestion + 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: navDrawer(context, questions, changePage),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            appbarText,
            style: TextStyle(
              color: primaryColor,
            ),
          ),
          actions: <Widget>[
            Center(
              child: Text(
                '30.09',
                style: TextStyle(
                    color: primaryColor, fontSize: 20, fontFamily: pfontFamily),
              ),
            ),
            SizedBox(width: 10)
          ],
          iconTheme: new IconThemeData(color: primaryColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: pageBody(questions[selectedQuestion], answers, updateAnswer,
            nextQuestion, prevQuestion),
      ),
    );
  }
}

Map<String, String> answers = {};

List<Map<String, dynamic>> questions = [
  {
    "id": "1",
    "question": "Identify the virus that shook the world in the year 2020",
    "options": {
      "0": "Option A",
      "1": "Option B",
      "2": "This is an option",
      "3": "Final Choice"
    }
  },
  {
    "id": "2",
    "question":
        "Only 3 options are present in this question so it can be used to test.",
    "options": {"0": "Option A", "1": "This is an option", "2": "Final Choice"}
  },
  {
    "id": "3",
    "question": "Thrid question is a ver good question",
    "options": {
      "0": "Option A",
      "1": "Option B",
      "2": "This is an option",
      "3": "Final Choice"
    }
  },
  {
    "id": "4",
    "question": "Book ihsgtdf jasgd asydg aisydg is a wonderful",
    "options": {
      "0": "Final Question choice",
      "1": "Option B",
      "2": "This is an option",
      "3": "Final Choice"
    }
  },
];
