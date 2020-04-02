
// Model for represeting event in List of events
class Event {
  int id;
  String name;
  String icon;
  String category;

  Event({this.id, this.name, this.icon, this.category});


  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      category: json['category'],
    );
  }

  Map<String,dynamic> toJson() {
    return ({
      'id'  : id,
      'name': name,
      'icon': icon,
      'category': category,
    });
  }
}
