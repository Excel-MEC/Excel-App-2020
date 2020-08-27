import 'dart:convert';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:http/http.dart' as http;

class EventsAPI {
  static fetchEventListFromStorage(String endpoint) async {
    print("- Event list $endpoint Storage fetch");
    var eventListData =
        await HiveDB().retrieveData(valueName: "event-$endpoint");
    if (eventListData == null) return;
    return eventListData.map<Event>((event) => Event.fromJson(event)).toList();
  }

  static fetchAndStoreEventListFromNet(String endpoint) async {
    print("- Event list $endpoint Network Fetch & storing in DB");
    try {
      var response =
          await http.get(APIConfig.baseUrl + '/events/type' + '/$endpoint');
      List responseData = json.decode(response.body);
      await HiveDB()
          .storeData(valueName: "event-$endpoint", value: responseData);
      return responseData.map<Event>((event) => Event.fromJson(event)).toList();
    } catch (_) {
      return ("error");
    }
  }

  // static Future<List<Event>> fetchEvents(String endpoint) async {
  //   var response;
  //   try {
  //     response =
  //         await http.get(APIConfig.baseUrl + '/events/type' + '/$endpoint');
  //   } catch (e) {
  //     print("Error $e");
  //     return null;
  //   }
  //   List<dynamic> responseData = json.decode(response.body);
  //   return responseData.map<Event>((event) => Event.fromJson(event)).toList();
  // }

  static Future<EventDetails> fetchEventDetails(int id) async {
    var response;
    try {
      response = await http.get(APIConfig.baseUrl + '/events/${id.toString()}');
    } catch (e) {
      print("Error $e");
      return null;
    }
    Map<String, dynamic> responseData = json.decode(response.body);
    responseData["eventHead1"] = json.encode(responseData["eventHead1"]);
    responseData["eventHead2"] = json.encode(responseData["eventHead2"]);
    responseData["rounds"] = json.encode(responseData["rounds"]);
    EventDetails event = EventDetails.fromJson(responseData);
    return event;
  }
}
