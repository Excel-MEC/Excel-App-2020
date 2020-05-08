
// Model for represeting event in List of events
class Event {
  int id;
  String name;
  String icon;
  String category;
  String dateTime;


  Event({this.id, this.name, this.icon, this.category, this.dateTime});


  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      category : json['category'],
      dateTime: convertTimeStamp(json['datetime']),
    );
  }

  Map<String,dynamic> toJson() {
    return ({
      'id'  : id,
      'name': name,
      'icon': icon,
      'category': category,
      'datetime': dateTime,
    });
  }

  // TODO: convert unix time stamp to required format
  static String convertTimeStamp(String date) {

  }
}
