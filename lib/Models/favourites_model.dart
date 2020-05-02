
class Favourites {
  String favId;
  int id;
  String name;
  String icon;
  String dateTime;
  String endpoint;

  Favourites({this.favId,this.id,this.name,this.icon,this.dateTime,this.endpoint});

  factory Favourites.fromJson(Map<String,dynamic> json) {
    return Favourites(
      favId: json['fav_id'],
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      dateTime: json['date_time'],
      endpoint: json['endpoint'],
    );
  }

  Map<String,dynamic> toJson() {
    return({
      'fav_id': favId,
      'id'    : id,
      'name'  : name,
      'icon'  : icon,
      'date_time' : dateTime,
      'endpoint': endpoint,
    });
  }
}