
// Model for representing each details of each Event

// class EventDetails {
//   int id;
//   String name;
//   String category;
//   String venue;
//   String prize;
//   String dateTime;

//   String about;
//   String format;
//   String rules;
//   List<dynamic> contacts;

//   EventDetails(
//       {this.id,
//       this.name,
//       this.category,
//       this.venue,
//       this.prize,
//       this.dateTime,
//       this.about,
//       this.format,
//       this.rules,
//       this.contacts});

//   factory EventDetails.fromJson(Map<String, dynamic> json) {
//     return EventDetails(
//         id: json['id'],
//         name: json['name'],
//         category: json['category'],
//         venue: json['venue'],
//         prize: json['prize_money'],
//         dateTime: json['date_time'],
//         about: json['about'],
//         format: json['format'],
//         rules: json['rules'],
//         // spelling mistake in api
//         contacts: json['conatcts']);
//   }

//   // Checking
//   Map<String, dynamic> toJson() {
//     return ({
//       'id': id,
//       'name': name,
//       'category': category,
//       'venue': venue,
//       'prize_money': prize,
//       'date_time': dateTime,
//       'about': about,
//       'format': format,
//       'rules': rules,
//       // no contacts added
//     });
//   }
// }



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
  String datetime;
  int entryFee;
  int prizeMoney;
  int eventHead1Id;
  EventHead1 eventHead1;
  int eventHead2Id;
  EventHead1 eventHead2;
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
    categoryId = json['categoryId'];
    category = json['category'];
    eventTypeId = json['eventTypeId'];
    eventType = json['eventType'];
    about = json['about'];
    format = json['format'];
    rules = json['rules'];
    venue = json['venue'];
    datetime = json['datetime'];
    entryFee = json['entryFee'];
    prizeMoney = json['prizeMoney'];
    eventHead1Id = json['eventHead1Id'];
    eventHead1 = json['eventHead1'] != null
        ? new EventHead1.fromJson(json['eventHead1'])
        : null;
    eventHead2Id = json['eventHead2Id'];
    eventHead2 = json['eventHead2'] != null
        ? new EventHead1.fromJson(json['eventHead2'])
        : null;
    isTeam = json['isTeam'];
    teamSize = json['teamSize'];
    eventStatusId = json['eventStatusId'];
    eventStatus = json['eventStatus'];
    numberOfRounds = json['numberOfRounds'];
    currentRound = json['currentRound'];
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
    data['datetime'] = this.datetime;
    data['entryFee'] = this.entryFee;
    data['prizeMoney'] = this.prizeMoney;
    data['eventHead1Id'] = this.eventHead1Id;
    if (this.eventHead1 != null) {
      data['eventHead1'] = this.eventHead1.toJson();
    }
    data['eventHead2Id'] = this.eventHead2Id;
    if (this.eventHead2 != null) {
      data['eventHead2'] = this.eventHead2.toJson();
    }
    data['isTeam'] = this.isTeam;
    data['teamSize'] = this.teamSize;
    data['eventStatusId'] = this.eventStatusId;
    data['eventStatus'] = this.eventStatus;
    data['numberOfRounds'] = this.numberOfRounds;
    data['currentRound'] = this.currentRound;
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
}