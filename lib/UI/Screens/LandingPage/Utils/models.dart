class Sponser {
  String imageUrl;
  String url;

  Sponser({this.imageUrl, this.url});

  Sponser.fromMapObject(Map<String, dynamic> map) {
    this.imageUrl = map['imageUrl'];
    this.url = map['url'];
  }
}


