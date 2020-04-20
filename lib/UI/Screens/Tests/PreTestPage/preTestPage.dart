import './scoreDialog.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';

class PreTestPage extends StatelessWidget {
  final Map<String, String> eventMap = {
    'name': 'Kryptos',
    'description': '''
Est et quasi laborum quas error ut velit molestiae. 
Aut et delectus ratione id tempore enim vel qui. 
Voluptatem sapiente eius rerum optio.
Quia qui qui et nam maxime. Non aut commodi nemo molestiae
a iste sint. Hic repellat ipsa molestias tempora. 
Nemo quidem illo aut commodi. Laudantium aut eius 
cupiditate dolor aut dolorem mollitia fugit.
Est quisquam quia repellendus est ut dolorem.
a iste sint. Hic repellat ipsa molestias tempora. 
Nemo quidem illo aut commodi. Laudantium aut eius 
cupiditate dolor aut dolorem mollitia fugit.
Est quisquam quia repellendus est ut dolorem.
    ''',
    'duration': '2 hr',
    'total_ques': '10',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SafeArea(
                child: Center(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                color: primaryColor,
                child: Center(
                  child: Text(
                    'Kryptos',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: pfontFamily),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Instructions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
                thickness: 3,
                indent: (MediaQuery.of(context).size.width / 2) - 15,
                endIndent: (MediaQuery.of(context).size.width / 2) - 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                height: (MediaQuery.of(context).size.height / 2.5),
                child: SingleChildScrollView(
                  child: Text(
                    eventMap['description'] * 3,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Test Duration',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                eventMap['duration'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Total Questions',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '10',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScoreDialog()));
                      },
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        'Start Test',
                        style: TextStyle(
                          color: Colors.indigo[900],
                          fontSize: 15,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(12.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
