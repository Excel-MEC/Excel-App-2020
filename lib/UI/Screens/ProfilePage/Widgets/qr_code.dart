import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/UI/Themes/profile_themes.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class QrCode extends StatelessWidget {
  final String imageUrl, qrUrl, name;
  QrCode(this.imageUrl, this.qrUrl, this.name);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // profile pic
              Container(
                height: MediaQuery.of(context).size.height/6,
                width: MediaQuery.of(context).size.height/6,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, image) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                    ), 
                  ),
                  placeholder: (context, str) => Center(child: CircularProgressIndicator()),
                ),
              ),
              // User name
              SizedBox(height: 5),
              Text(
                name,
                style: ProfileTheme.nameStyle,
              ),
              // QR code
              SizedBox(height: 7),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: primaryColor,
                textColor: Colors.white,
                child: Text(
                  'SHOW QR CODE',
                  style: ProfileTheme.buttonTextStyle,
                ),
                onPressed: () => qrDialog(context,qrUrl)
              ),
            ],
          ),
        ),
      ),
    );
  }
}


qrDialog(BuildContext context,String qrUrl) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(context).size.height/2,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width/2,
            child: CachedNetworkImage(
              imageUrl: qrUrl,
              placeholder: (context,str) => Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      );
    }
  );
}
