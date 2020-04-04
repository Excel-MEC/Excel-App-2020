
// Model for representing each details of each Event

class EventDetails {
  int id;
  String name;
  String category;
  String venue;
  String prize;
  String dateTime;

  String about;
  String format;
  String rules;
  List<dynamic> contacts;

  EventDetails(
      {this.id,
      this.name,
      this.category,
      this.venue,
      this.prize,
      this.dateTime,
      this.about,
      this.format,
      this.rules,
      this.contacts});

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    return EventDetails(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        venue: json['venue'],
        prize: json['prize_money'],
        dateTime: json['date_time'],
        about: json['about'],
        format: json['format'],
        rules: json['rules'],
        // spelling mistake in api
        contacts: json['conatcts']);
  }

  // Checking
  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'name': name,
      'category': category,
      'venue': venue,
      'prize': prize,
      'date': dateTime,
      'about': about,
      'format': format,
      'rules': rules,
      // no contacts added
    });
  }

  // TODO: function to convert unix time stamp to String
}
