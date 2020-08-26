import 'package:excelapp/UI/Components/LoadingUI/snackBar.dart';
import 'package:excelapp/UI/Screens/HomePage/Widgets/Drawer/drawer.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_share/social_share.dart';

class SharingOptions extends StatelessWidget {
  final String referalCode;
  SharingOptions({this.referalCode});
  @override
  Widget build(BuildContext context) {
    String siteUrl =
        "https://staging.accounts.excelmec.org/auth/login?referral=$referalCode";
    String appUrl =
        "https://play.google.com/store/apps/details?id=org.excelmec";
    String intro = "Come join us at Excel 2020\n";
    String message =
        "$intro Logon to our website: $siteUrl\nOr install our app: $appUrl \n and use referal code $referalCode";
    // print(message);
    return Container(
      margin: EdgeInsets.all(13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Email
          ShareOption(
            icon: Icons.mail_outline,
            color: Color(0xff666666),
            action: () {
              String encodedMessage = Uri.encodeComponent(
                  "$intro ! <br>Logon to our website: $siteUrl <br><br>Or install our app: $appUrl <br> and use referal code $referalCode");
              final Uri params = Uri(
                scheme: 'mailto',
                path: '',
                query:
                    'subject=Come join us at Excel 2020&body=$encodedMessage',
              );
              launchURL(params.toString());
            },
          ),
          // Facebook
          ShareOption(
            icon: FontAwesomeIcons.facebookF,
            color: Color(0xff3b5998),
            action: () {
              var urlmessage = Uri.encodeComponent(message);
              var encodedURL = Uri.encodeComponent(siteUrl);
              launchURL(
                  "https://www.facebook.com/sharer/sharer.php?u=$encodedURL&quote=$urlmessage");
            },
          ),
          // Twitter
          ShareOption(
            icon: FontAwesomeIcons.twitter,
            color: Color(0xff00acee),
            action: () {
              SocialShare.shareTwitter(
                Uri.encodeComponent(message),
                url: "",
                trailingText: "",
                hashtags: ["ExcelMEC", "Excel2020"],
              );
            },
          ),
          // Whatsapp
          ShareOption(
            icon: FontAwesomeIcons.whatsapp,
            color: Color(0xff4FCE5D),
            action: () {
              SocialShare.shareWhatsapp(message);
            },
          ),
          // Telegram
          ShareOption(
            icon: FontAwesomeIcons.telegramPlane,
            color: Color(0xff0088cc),
            action: () {
              SocialShare.shareTelegram(message);
            },
          ),
          // Copy to clipboard
          ShareOption(
            icon: Icons.content_copy,
            color: primaryColor,
            action: () async {
              await SocialShare.copyToClipboard(
                message,
              );
              Scaffold.of(context).showSnackBar(
                snackBar("Message Copied"),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ShareOption extends StatelessWidget {
  final Function action;
  final IconData icon;
  final Color color;
  ShareOption({this.action, this.icon, this.color});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 17,
        ),
      ),
    );
  }
}
