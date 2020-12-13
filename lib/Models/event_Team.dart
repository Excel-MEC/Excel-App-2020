class TeamDetails {
  int id;
  String name;
  int eventId;

  TeamDetails({this.id, this.name, this.eventId});

  TeamDetails.fromJson(json) {
    id = json['id'];
    name = json['name'];
    eventId = json['eventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['eventId'] = this.eventId;

    return data;
  }
}
