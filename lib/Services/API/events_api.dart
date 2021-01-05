import 'dart:convert';
import 'package:excelapp/Accounts/getAuthorisedData.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:http/http.dart' as http;

class EventsAPI {
  static fetchEventListFromStorage(String endpoint) async {
    print("- Event list $endpoint Storage fetch");
    var eventListData =
        await HiveDB.retrieveData(valueName: "eventlist-$endpoint");
    if (eventListData == null) return;
    return eventListData.map<Event>((event) => Event.fromJson(event)).toList();
  }

  static fetchAndStoreEventListFromNet(String endpoint) async {
    print("- Event list $endpoint network fetch");
    try {
      var response =
          await http.get(APIConfig.baseUrl + '/events/type' + '/$endpoint');
      List responseData = json.decode(response.body);
      await HiveDB.storeData(
          valueName: "eventlist-$endpoint", value: responseData);
      return responseData.map<Event>((event) => Event.fromJson(event)).toList();
    } catch (e) {
      print("Error $e");
      return ("error");
    }
  }

  static fetchEventDetailsFromStorage(int id) async {
    print("- Event Details: $id Storage fetch");
    var eventDetailsData =
        await HiveDB.retrieveData(valueName: "eventdetails-$id");
    if (eventDetailsData == null) return;
    EventDetails event = EventDetails.fromJson(eventDetailsData);
    return event;
  }

  static fetchAndStoreEventDetailsFromNet(int id) async {
    print("- Event list $id network fetch");
    try {
      var response = await getAuthorisedData(APIConfig.baseUrl + '/events/$id');

      Map<String, dynamic> responseData = json.decode(response.body);
      responseData["eventHead1"] = json.encode(responseData["eventHead1"]);
      responseData["eventHead2"] = json.encode(responseData["eventHead2"]);
      responseData["rounds"] = json.encode(responseData["rounds"]);
      responseData["registration"] = json.encode(responseData["registration"]);

      await HiveDB.storeData(
          valueName: "eventdetails-$id", value: responseData);
      EventDetails event = EventDetails.fromJson(responseData);
      return event;
    } catch (e) {
      print("Error $e");
      return ("error");
    }
  }

  static deleteEventDetailsfromDB(int id) {
    HiveDB.deleteData(valueName: "eventdetails-$id");
  }
}
