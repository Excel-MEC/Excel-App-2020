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
    String refUrl =
        "https://staging.accounts.excelmec.org/auth/login?referral=$referalCode";
    String message = "Come join us at Excel 2020\n" + refUrl;
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
              final Uri params = Uri(
                scheme: 'mailto',
                path: '',
                query: 'subject=Welcome to Excel 2020&body=$message',
              );
              launchURL(params.toString());
            },
          ),
          // Facebook
          ShareOption(
            icon: FontAwesomeIcons.facebookF,
            color: Color(0xff3b5998),
            action: () {
              var urlmessage =
                  Uri.encodeComponent("Come Join us at Excel 2020");
              var encodedURL = Uri.encodeComponent(
                  "https://staging.accounts.excelmec.org/auth/login?referral=$referalCode");
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
                "This is Social Share plugin",
                url: refUrl,
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
