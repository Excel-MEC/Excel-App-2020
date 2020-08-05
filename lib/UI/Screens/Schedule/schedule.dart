import 'dart:async';
import 'dart:convert';
import 'package:excelapp/UI/Screens/Schedule/Widgets/schedulePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:excelapp/Services/API/api_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  StreamController<dynamic> estream;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  fetchSchedule() async {
    print("Fetching");
    try {
      var response = await http.get(APIConfig.baseUrl + "/schedule");
      var responseData = json.decode(response.body);
      var scheduleData = {"day1": [], "day2": [], "day3": []};
      for (var i in responseData) {
        if (i["day"] == 1)
          scheduleData["day1"] = i["events"];
        else if (i["day"] == 2)
          scheduleData["day2"] = i["events"];
        else if (i["day"] == 3) scheduleData["day3"] = i["events"];
      }
      estream.add(scheduleData);
    } catch (_) {
      estream.add("error");
    }
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    estream = StreamController<dynamic>();
    fetchSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        onRefresh: fetchSchedule,
        controller: _refreshController,
        child: StreamBuilder(
          stream: estream.stream,
          builder: (context, snapshot) {
            if (snapshot.data == "error")
              return Center(
                child: Text("An error occured, pull down to refresh"),
              );
            if (snapshot.hasData)
              return SchedulePage(scheduleData: snapshot.data);
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
