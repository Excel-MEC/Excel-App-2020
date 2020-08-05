import 'package:intl/intl.dart';

class ScheduleModel {
  int id;
  String name;
  String icon;
  String eventType;
  String category;
  bool needRegistration;
  String round;
  int day;
  String datetime;

  ScheduleModel(
      {this.id,
      this.name,
      this.icon,
      this.eventType,
      this.category,
      this.needRegistration,
      this.round,
      this.day,
      this.datetime});

  ScheduleModel.fromJson(json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    eventType = json['eventType'];
    category = json['category'];
    needRegistration = json['needRegistration'];
    round = json['round'];
    day = json['day'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['eventType'] = this.eventType;
    data['category'] = this.category;
    data['needRegistration'] = this.needRegistration;
    data['round'] = this.round;
    data['day'] = this.day;
    data['datetime'] = this.datetime;
    return data;
  }
}

class ScheduleDateTimeConversion {
  static String dateTimeToString(String dateTime) {
    DateTime dateObject = DateTime.parse(dateTime);
    String result = DateFormat.jm().format(dateObject);
    return result;
  }
}
