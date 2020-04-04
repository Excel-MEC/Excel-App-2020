import 'dart:convert';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/API/api_config.dart';
import 'package:http/http.dart' as http;


class EventsAPI {

  // Fetches a list of events from the endpoint
  static Future<List<Event>> fetchEvents(String endpoint) async {
    var response;
    try {
      response = await http.get(APIConfig.baseUrl+'/$endpoint');
    } catch (e) {
      print("Error $e");
    }
    Map<String, dynamic> responseData = json.decode(response.body);
    return responseData['events']
        .map<Event>((event) => Event.fromJson(event))
        .toList();
  }

  // Fetch event details from endpoint
  static Future<EventDetails> fetchEventDetails(String endpoint,int id) async {
    var response;
    try {
      response = await http.get(APIConfig.baseUrl+'/$endpoint/${id.toString()}');
    } catch (e) {
      print("Error $e");
    }
    Map<String,dynamic> responseData = json.decode(response.body);
    EventDetails event = EventDetails.fromJson(responseData);
    return event;
  }

}