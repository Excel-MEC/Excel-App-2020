import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

var sponserModalMap = [
  {
    "imageUrl": "https://excelmec.org/static/media/townscript.937ed107.png",
    "url": "https://www.townscript.com/"
  },
  {
    "imageUrl": "https://excelmec.org/static/media/EVENTOZ-logo.0bbb0a15.png",
    "url": "https://www.eventoz.co.in/"
  },
  {
    "imageUrl":
        "https://excelmec.org/static/media/TheNewIndianExp.db7277a1.png",
    "url": "http://www.newindianexpress.com/"
  }
];

class Sponser {
  String imageUrl;
  String url;

  Sponser({this.imageUrl, this.url});

  Sponser.fromMapObject(Map<String, dynamic> map) {
    this.imageUrl = map['imageUrl'];
    this.url = map['url'];
  }
}

class SponserCards extends StatefulWidget {
  @override
  SponserCardsState createState() => SponserCardsState();
}

class SponserCardsState extends State<SponserCards> {
  List<Sponser> sponsers;
  double cardHeight = 120;

  @override
  void initState() {
    super.initState();
    sponsers = List<Sponser>();
    for (int i = 0; i < sponserModalMap.length; i++) {
      sponsers.add(Sponser.fromMapObject(sponserModalMap[i]));
    }

    //debug
    print("Sponsers: ${sponsers.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sponsers.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                    width: 120,
                    margin: EdgeInsets.all(8),
                    child: CachedNetworkImage(
                      imageUrl: sponsers[index].imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      ),
                    )),
                onPressed: () async {
                  _launchURL(sponsers[index].url);
                },
              ),
            );
          }),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
