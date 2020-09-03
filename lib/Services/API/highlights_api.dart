import 'dart:convert';
import 'package:excelapp/Models/highlights_model.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:http/http.dart' as http;

fetchHighlightsFromStorage() async {
  print("-    Highlights: Storage Fetch    -");
  var highlightsData = await HiveDB.retrieveData(valueName: "highlights");
  if (highlightsData == null) return;
  return highlightsData
      .map<Highlights>((highlight) => Highlights.fromJson(highlight))
      .toList();
}

fetchAndStoreHighlightsFromNet() async {
  print("-    Highlights: Network Fetch    -");
  try {
    var response = await http.get(APIConfig.baseUrl + "/highlights");
    List responseData = json.decode(response.body);
    await HiveDB.storeData(valueName: "highlights", value: responseData);
    return responseData
        .map<Highlights>((highlight) => Highlights.fromJson(highlight))
        .toList();
  } catch (_) {
    return ("error");
  }
}
