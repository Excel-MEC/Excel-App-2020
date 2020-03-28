import 'package:cached_network_image/cached_network_image.dart';
import 'Utils/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Utils/constants.dart';
import 'Utils/data.dart';

class WelcomeCard extends StatelessWidget {
  final double cardHeight = screenSize.height / 2.1;
  final Radius cardRoundness = Radius.circular(32);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: cardRoundness, topRight: cardRoundness)),
        width: screenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: pill(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(28, 12, 0, 0),
              child: title(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 24),
              child: SponserCards(),
            ),
          ],
        ),
      ),
    );
  }

  pill() {
    return Container(
      //pill shaped

      width: 48,
      // decoration: BoxDecoration(
      //     color: primaryColor, borderRadius: BorderRadius.circular(16)),

      //arrow
      child: Icon(Icons.keyboard_arrow_up, size: 48, color: primaryColor),
    );
  }

  title() {
    double subtitleSize = 22;
    double titleSize = 40;
    double headingSize = 16;
    var subtitleWeight = FontWeight.w300;
    var titleWeight = FontWeight.w700;
    var headingWeight = FontWeight.w600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Welcome To",
            style: TextStyle(
                color: primaryColor,
                fontFamily: pfontFamily,
                fontWeight: subtitleWeight,
                fontSize: subtitleSize)),
        Text("Excel 2020",
            style: TextStyle(
                color: primaryColor,
                fontFamily: pfontFamily,
                fontWeight: titleWeight,
                fontSize: titleSize)),
        Padding(padding: EdgeInsets.all(8)),
        Text("Sponsered By",
            style: TextStyle(
                color: primaryColor,
                fontFamily: pfontFamily,
                fontWeight: headingWeight,
                fontSize: headingSize))
      ],
    );
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
