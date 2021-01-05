import 'dart:async';
import 'package:excelapp/Services/API/schedule_api.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/Screens/Schedule/Widgets/schedulePage.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  bool dataLoaded = false;
  StreamController<dynamic> estream;

  fetchfromNet() async {
    var dataFromNet = await fetchAndStoreScheduleFromNet();
    if (!dataLoaded || dataFromNet != "error") {
      estream.add(dataFromNet);
      dataLoaded = true;
    }
  }

  initialisePage() async {
    var datafromStorage = await fetchScheduleFromStorage();
    if (datafromStorage != null) {
      estream.add(datafromStorage);
      dataLoaded = true;
    }
    await fetchfromNet();
  }

  @override
  void initState() {
    estream = StreamController<dynamic>();
    initialisePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: estream.stream,
        builder: (context, snapshot) {
          // If couldnt fetch
          if (snapshot.data == "error") return errorRetry();
          // If got data
          if (snapshot.hasData)
            return new SchedulePage(scheduleData: snapshot.data);
          // When loading
          return LoadingAnimation();
        },
      ),
    );
  }

  Widget errorRetry() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Couldn't fetch Schedule",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30),
          RaisedButton(
            color: primaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Schedule(),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
