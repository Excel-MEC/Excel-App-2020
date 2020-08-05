import 'dart:convert';
import 'package:excelapp/Models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:excelapp/Services/API/api_config.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

fetchScheduleFromStorage() async {
  print("- Fetching from storage: Schedule -");
  Directory dir = await getApplicationDocumentsDirectory();
  await dir.create(recursive: true); // make sure it exists
  Hive.init(join(dir.path, 'hiveDB'));
  Box box = await Hive.openBox("excel");
  Map<String, dynamic> scheduleData = box.get("schedule");
  if (scheduleData == null) return;
  return scheduleJSONtoModel(scheduleData);
}

fetchScheduleFromNet() async {
  print("- Fetching from net: Schedule -");
  try {
    var response = await http.get(APIConfig.baseUrl + "/schedule");
    List responseData = json.decode(response.body);
    Map<String, dynamic> scheduleData = {"day1": [], "day2": [], "day3": []};
    for (var i in responseData) {
      if (i["day"] == 1)
        scheduleData["day1"] = i["events"];
      else if (i["day"] == 2)
        scheduleData["day2"] = i["events"];
      else if (i["day"] == 3) scheduleData["day3"] = i["events"];
    }

    // Store data with Hive
    Directory dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true); // make sure it exists
    Hive.init(join(dir.path, 'hiveDB'));
    Box box = await Hive.openBox("excel");
    await box.put("schedule", scheduleData);

    return scheduleJSONtoModel(scheduleData);
  } catch (_) {
    return ("error");
  }
}

scheduleJSONtoModel(json) {
  var result = {};
  result["day1"] = json["day1"]
      .map<ScheduleModel>((event) => ScheduleModel.fromJson(event))
      .toList();
  result["day2"] = json["day2"]
      .map<ScheduleModel>((event) => ScheduleModel.fromJson(event))
      .toList();
  result["day3"] = json["day3"]
      .map<ScheduleModel>((event) => ScheduleModel.fromJson(event))
      .toList();
  return result;
}
