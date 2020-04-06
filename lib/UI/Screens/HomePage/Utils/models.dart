class Event {
  String eventName;
  String imageUrl;
  String date;
  String time;

  Event({this.eventName, this.imageUrl, this.date, this.time});

  Event.fromMapObject(Map<String, dynamic> map){
    this.eventName = map['eventName'];
    this.imageUrl = map['imageUrl'];
    this.date = map['date'];
    this.time = map['time'];
  }
}

class Person {
  String name;
  String imageUrl;
  String qrUrl;
  String email;
  String phone;

  Person({this.name, this.imageUrl,this.qrUrl, this.email, this.phone});

  Person.fromMapObject(Map<String, dynamic> map){
    this.name = map['name'];
    this.imageUrl = map['imgUrl'];
    this.qrUrl = map['qrUrl'];
    this.phone = map['phone'];
    this.email = map['email'];
  }
}

