import 'package:intl/intl.dart';

class Event {
  int id;
  String name;
  String icon;
  String eventType;
  String category;
  String datetime;

  Event(
      {this.id,
      this.name,
      this.icon,
      this.eventType,
      this.category,
      this.datetime});

  Event.fromJson(json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    eventType = json['eventType'];
    category = json['category'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['eventType'] = this.eventType;
    data['category'] = this.category;
    data['datetime'] = this.datetime;
    return data;
  }
}

class DateTimeConversion {
  static String dateTimeToString(String dateTime) {
    DateTime dateObject = DateTime.parse(dateTime);
    String result = DateFormat('dd MMM yyyy').format(dateObject) +
        ' | ' +
        DateFormat.jm().format(dateObject);
    return result;
  }
}
