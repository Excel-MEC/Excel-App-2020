import 'dart:convert';
import 'package:excelapp/Models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';

fetchScheduleFromStorage() async {
  print("-    Schedule: Storage Fetch    -");
  var scheduleData = await HiveDB.retrieveData(valueName: "schedule");
  if (scheduleData == null) return;
  return scheduleJSONtoModel(scheduleData);
}

fetchAndStoreScheduleFromNet() async {
  print("-    Schedule: Network Fetch    -");
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

    // Updates in DB
    await HiveDB.storeData(valueName: "schedule", value: scheduleData);

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
