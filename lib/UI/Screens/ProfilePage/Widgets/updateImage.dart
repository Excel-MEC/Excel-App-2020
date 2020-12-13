import 'dart:convert';
import 'package:excelapp/Accounts/account_config.dart';
import 'package:excelapp/Accounts/getAuthorisedData.dart';
import 'package:excelapp/Accounts/refreshToken.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:excelapp/main.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:excelapp/Models/user_model.dart';
import 'package:excelapp/Services/Database/hive_operations.dart';
import 'package:excelapp/UI/Components/AlertDialog/alertDialog.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImgUpload extends StatefulWidget {
  final String imgUrl;
  ImgUpload({@required this.imgUrl});
  @override
  _ImgUploadState createState() => _ImgUploadState();
}

class _ImgUploadState extends State<ImgUpload> {
  File _image;
  bool isLoading = false;
  final picker = ImagePicker();

  Future getImage({@required bool fromGallery}) async {
    var pickedFile;
    try {
      pickedFile = await picker.getImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
    } catch (e) {
      print("Error $e");
      return;
    }
    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });
    submitImage();
  }

  uploadImageHTTP(file) async {
    // If image not chosen
    if (file == null) {
      alertDialog(text: "Choose image", context: context);
      return;
    }

    var url = 'https://staging.accounts.excelmec.org/api/Profile/update/image';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['authorization'] = "Bearer $jwt";
    request.headers["Content-Type"] = "application/json";
    request.headers["Accept"] = "application/json";

    request.files.add(await http.MultipartFile.fromPath('Image', file.path));
    print("Updating image");

    var response;

    setState(() {
      isLoading = true;
    });
    try {
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      // If token expired it is refreshed, but request fails
      if (response.statusCode == 455) {
        return "tokenExpired";
      }
      if (response.statusCode == 200) {
        print("Success");
        // Fetching & storing new profile data
        print("Fetching user details");
        var response = await getAuthorisedData(AccountConfig.url + 'profile');
        Map<String, dynamic> responseData = json.decode(response.body);
        User user = User.fromJson(responseData);
        print("Adding to DB");
        await HiveDB.storeData(valueName: "user", value: user.toJson());
        // Clearing image cache
        await DefaultCacheManager().removeFile(user.picture);
        imageCache.clear();
        await Future.delayed(Duration(milliseconds: 100));
        // Restart App to clear existing cache
        runApp(new Center());
        runApp(new MyApp());
      } else
        alertDialog(
            text: "Failed to update image, Try again", context: context);
    } catch (e) {
      print("Error $e");
      alertDialog(text: "Failed to update image", context: context);
    }
    setState(() {
      isLoading = false;
    });
  }

  submitImage() async {
    var res = await uploadImageHTTP(_image);
    // Handle token expiry
    if (res == "tokenExpired") {
      await refreshToken();
      await uploadImageHTTP(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Update Image"),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                    spreadRadius: 0,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: MediaQuery.of(context).size.height / 9,
                backgroundImage: _image == null
                    ? NetworkImage(
                        widget.imgUrl,
                      )
                    : FileImage(_image),
              ),
            ),
          ),
          SizedBox(height: 50),
          isLoading
              ? Column(
                  children: [
                    Text(
                      "Uploading Image",
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                    SizedBox(height: 30),
                    LoadingAnimation(),
                  ],
                )
              : Column(
                  children: [
                    imageOption(
                      optionName: "Choose Photo",
                      icon: Icons.photo_library,
                      onPressed: () {
                        getImage(fromGallery: true);
                      },
                    ),
                    SizedBox(height: 15),
                    imageOption(
                      optionName: "Use Camera",
                      icon: Icons.camera_alt,
                      onPressed: () {
                        getImage(fromGallery: false);
                      },
                    ),
                  ],
                ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget imageOption({String optionName, Function onPressed, IconData icon}) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        child: RaisedButton(
          elevation: 5,
          color: primaryColor,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  optionName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
