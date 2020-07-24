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
  int isTeam;
  int teamSize;
  int eventStatusId;
  String eventStatus;
  int numberOfRounds;
  int currentRound;
  int needRegistration;
  String rounds;

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
    eventHead1Id = json['eventHead1Id'];
    eventHead1 = jsonEncode(json['eventHead1']);
    eventHead2Id = json['eventHead2Id'];
    eventHead2 = jsonEncode(json['eventHead2']);
    isTeam = (json['isTeam'] == true || json['isTeam'] == 1) ? 1 : 0;
    teamSize = json['teamSize'];
    eventStatusId = json['eventStatusId'];
    eventStatus = json['eventStatus'];
    numberOfRounds = json['numberOfRounds'];
    currentRound = json['currentRound'];
    needRegistration =
        (json['needRegistration'] == true || json['needRegistration'] == 1)
            ? 1
            : 0;
    rounds = jsonEncode(json['rounds']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category;
    data['eventTypeId'] = this.eventTypeId;
    data['eventType'] = this.eventType;
    data['about'] = this.about;
    data['format'] = this.format;
    data['rules'] = this.rules;
    data['venue'] = this.venue;
    data['day'] = this.day;
    data['datetime'] = this.datetime;
    // data['entryFee]'] = this.entryFee;
    data['prizeMoney'] = this.prizeMoney;
    data['eventHead1Id'] = this.eventHead1Id;
    data['eventHead1'] = this.eventHead1;
    data['eventHead2Id'] = this.eventHead2Id;
    data['eventHead2'] = this.eventHead2;
    data['isTeam'] = this.isTeam;
    data['teamSize'] = this.teamSize;
    data['eventStatusId'] = this.eventStatusId;
    data['eventStatus'] = this.eventStatus;
    data['numberOfRounds'] = this.numberOfRounds;
    data['currentRound'] = this.currentRound;
    data['needRegistration'] = this.needRegistration;
    data['rounds'] = this.rounds;
    return data;
  }
}
