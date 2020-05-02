
class Favourites {
  int id;
  String name;
  String icon;
  String dateTime;
  String tableName;

  Favourites({this.id,this.name,this.icon,this.dateTime,this.tableName});

  factory Favourites.fromJson(Map<String,dynamic> json) {
    return Favourites(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      dateTime: json['date_time'],
      tableName: json['table_name'],
    );
  }

  Map<String,dynamic> toJson() {
    return({
      'id'    : id,
      'name'  : name,
      'icon'  : icon,
      'date_time' : dateTime,
      'table_name': tableName,
    });
  }
}