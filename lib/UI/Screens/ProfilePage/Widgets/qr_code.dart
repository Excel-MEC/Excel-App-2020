import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/UI/Screens/ProfilePage/Widgets/updateImage.dart';
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
              // Profile pic
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: MediaQuery.of(context).size.height / 14,
                    backgroundImage: CachedNetworkImageProvider(
                      imageUrl,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImgUpload(imgUrl: imageUrl)),
                      );
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black45,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ),
                ],
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
                  onPressed: () => qrDialog(context, qrUrl)),
            ],
          ),
        ),
      ),
    );
  }
}

qrDialog(BuildContext context, String qrUrl) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        margin: EdgeInsets.only(bottom: 60),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: qrUrl,
            width: MediaQuery.of(context).size.width * .60,
            placeholder: (context, str) =>
                Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    },
  );
}
