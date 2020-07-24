import 'dart:convert';

class EventDetails {
  int id;
  String name;
  String icon;
  int categoryId;
  String category;
  int eventTypeId;
  String eventType;
  String about;
  String format;
  String rules;
  String venue;
  int day;
  String datetime;
  int entryFee;
  int prizeMoney;
  int eventHead1Id;
  String eventHead1;
  int eventHead2Id;
  String eventHead2;

  bool isTeam;
  int teamSize;
  int eventStatusId;
  String eventStatus;
  int numberOfRounds;
  int currentRound;
  bool needRegistration;
  List rounds;

  EventDetails({
    this.id,
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
    this.day,
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
    this.currentRound,
    this.needRegistration,
    this.rounds,
  });

  EventDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    categoryId = json['categoryId'];
    category = json['category'];
    eventTypeId = json['eventTypeId'];
    eventType = json['eventType'];
    about = json['about'];
    format = json['format'];
    rules = json['rules'];
    venue = json['venue'];
    day = json['day'];
    datetime = json['datetime'];
    entryFee = json['entryFee'];
    prizeMoney = json['prizeMoney'];
    eventHead1Id = json.containsKey('eventHead1Id') ? json['eventHead1Id'] : 0;
    eventHead1 = json.containsKey('eventHead1') && json['eventHead1'] != null
        ? jsonEncode(json['eventHead1'])
        : null;
    eventHead2Id = json.containsKey('eventHead2Id') ? json['eventHead2Id'] : 0;
    eventHead2 = json.containsKey('eventHead2') && json['eventHead2'] != null
        ? jsonEncode(json['eventHead2'])
        : null;
    isTeam = json['isTeam'];
    teamSize = json['teamSize'];
    eventStatusId = json['eventStatusId'];
    eventStatus = json['eventStatus'];
    numberOfRounds = json['numberOfRounds'];
    currentRound = json['currentRound'];
    needRegistration = json['needRegistration'];
    rounds = json['rounds'];
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

// class EventHead1 {
//   int id;
//   String name;
//   String email;
//   String phoneNumber;

//   EventHead1({this.id, this.name, this.email, this.phoneNumber});

//   EventHead1.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phoneNumber = json['phoneNumber'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phoneNumber'] = this.phoneNumber;
//     return data;
//   }
// }
