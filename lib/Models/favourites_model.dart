
class Favourites {
  String favId;
  int id;
  String name;
  String icon;
  String dateTime;
  String tableName;

  Favourites({this.favId,this.id,this.name,this.icon,this.dateTime,this.tableName});

  factory Favourites.fromJson(Map<String,dynamic> json) {
    return Favourites(
      favId: json['fav_id'],
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      dateTime: json['date_time'],
      tableName: json['table_name'],
    );
  }

  Map<String,dynamic> toJson() {
    return({
      'fav_id': favId,
      'id'    : id,
      'name'  : name,
      'icon'  : icon,
      'date_time' : dateTime,
      'table_name': tableName,
    });
  }
}