import 'package:intl/intl.dart';

class EventDetails {
  int id;
  String name;
  String icon;
  String datetime;
  int prizeMoney;
  String venue;
  String about;
  String format;
  String rules;
  int eventHead1Id;
  EventHead1 eventHead1;
  int eventHead2Id;
  EventHead1 eventHead2;

  int categoryId;
  String category;
  int eventTypeId;
  String eventType;
  int entryFee;
  bool isTeam;
  int teamSize;
  int eventStatusId;
  String eventStatus;
  int numberOfRounds;
  int currentRound;

  EventDetails(
      {this.id,
      this.name,
      this.icon,
      this.categoryId,
      this.category,
      this.eventTypeId,
      this.eventType,
      this.about,
      this.format,
      this.rules,
      this.venue,
      this.datetime,
      this.entryFee,
      this.prizeMoney,
      this.eventHead1Id,
      this.eventHead1,
      this.eventHead2Id,
      this.eventHead2,
      this.isTeam,
      this.teamSize,
      this.eventStatusId,
      this.eventStatus,
      this.numberOfRounds,
      this.currentRound});

  EventDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    about = json['about'];
    format = json['format'];
    rules = json['rules'];
    venue = json['venue'];
    datetime = json['datetime'];
    prizeMoney = json['prizeMoney'];
    eventHead1Id = json.containsKey('eventHead1Id') ? json['eventHead1Id'] : 0;
    eventHead1 = json.containsKey('eventHead1') && json['eventHead1'] != null
        ? new EventHead1.fromJson(json['eventHead1'])
        : null;
    eventHead2Id = json.containsKey('eventHead2Id') ? json['eventHead2Id'] : 0;
    eventHead2 = json.containsKey('eventHead2') && json['eventHead2'] != null
        ? new EventHead1.fromJson(json['eventHead2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['datetime'] = this.datetime;
    data['prizeMoney'] = this.prizeMoney;
    data['venue'] = this.venue;
    data['about'] = this.about;
    data['format'] = this.format;
    data['rules'] = this.rules;
    return data;
  }
}

class EventHead1 {
  int id;
  String name;
  String email;
  String phoneNumber;

  EventHead1({this.id, this.name, this.email, this.phoneNumber});

  EventHead1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }

  String dateTimeToString(String dateTime) {
    DateTime dateObject = DateTime.parse(dateTime);
    String result = DateFormat('dd MMM yyyy').format(dateObject) +
        ' | ' +
        DateFormat.jm().format(dateObject);
    return result;
  }
}
