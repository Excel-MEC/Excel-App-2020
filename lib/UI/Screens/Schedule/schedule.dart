import 'dart:async';
import 'package:excelapp/Services/API/schedule_api.dart';
import 'package:excelapp/UI/Screens/Schedule/Widgets/schedulePage.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  StreamController<dynamic> estream;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  fetchfromNet() async {
    var dataFromNet = await fetchScheduleFromNet();
    estream.add(dataFromNet);
    _refreshController.refreshCompleted();
  }

  initialisePage() async {
    var datafromStorage = await fetchScheduleFromStorage();
    if (datafromStorage != null) estream.add(datafromStorage);
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
      body: SmartRefresher(
        enablePullDown: true,
        onRefresh: fetchfromNet,
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
