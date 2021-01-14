import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: <Widget>[
          Text(
            'Stay in Touch !',
            style: TextStyle(
              // fontFamily: pfontFamily,
              fontSize: 18.0,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  print('object');
                },
                child: _buildIconCard(FontAwesomeIcons.facebookF,
                    'https://www.facebook.com/excelmec/'),
              ),
              SizedBox(
                width: 10.0,
              ),
              _buildIconCard(
                  FontAwesomeIcons.twitter, 'https://twitter.com/excelmec'),
              SizedBox(
                width: 10.0,
              ),
              _buildIconCard(FontAwesomeIcons.instagram,
                  'https://www.instagram.com/excelmec'),
              SizedBox(
                width: 10.0,
              ),
              _buildIconCard(FontAwesomeIcons.linkedinIn,
                  'https://www.linkedin.com/company/excelmec'),
            ],
          )
        ],
      ),
    );
  }
}

Widget _buildIconCard(IconData icon, String url) {
  return InkWell(
    onTap: () {
      launchURL(url);
    },
    child: Container(
      height: 60.0,
      width: 60.0,
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 10.0,
        shadowColor: Colors.white70,
        child: Icon(
          icon,
          color: primaryColor,
        ),
      ),
    ),
  );
}

launchURL(url) async {
  await launch(url);
}
