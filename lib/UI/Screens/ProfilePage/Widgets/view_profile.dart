import 'package:excelapp/Accounts/account_services.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('View Profile'),
      body: FutureBuilder(
        future: AccountServices.viewProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            // TODO : Proper UI for View Profile
            return Container(
              child: Column(
                children: <Widget>[
                  Text(snapshot.data.name),
                  Text(snapshot.data.email),
                  Text(snapshot.data.category),
                  Text(snapshot.data.institutionName),
                  Text(snapshot.data.gender),
                  Text(snapshot.data.mobileNumber),
                ],
              ),
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}