import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

// Sample data
// [
// {"name":"name",
// "email":"abcd@gmail.com",
// "isPaid":false
// },
// similarly
// ]

class ReferedUsers extends StatelessWidget {
  final List referedUsers;
  ReferedUsers({this.referedUsers});
  @override
  Widget build(BuildContext context) {
    String referalText;
    String ref = referedUsers.length == 1 ? "Referal" : "Referals";
    referalText = referedUsers.isEmpty
        ? "No Refered Users"
        : "Your Have " + referedUsers.length.toString() + " $ref";
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 10,
            color: Colors.white,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
              SizedBox(height: 15),
              line(),
              SizedBox(height: 15),
              Icon(
                referedUsers.isEmpty ? Icons.info_outline : Icons.stars,
                color: referedUsers.isEmpty ? Colors.grey : Color(0xff6c63fe),
                size: 30,
              ),
              SizedBox(height: 15),
              Text(
                referalText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Color(0xaa000000)),
              ),
              SizedBox(height: 15),
              referedUsers.isEmpty ? Container() : line(),
            ] +
            List.generate(
              referedUsers.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  dense: true,
                  leading: CircleAvatar(
                    radius: 15.5,
                    backgroundColor: primaryColor,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  title: Text(referedUsers[index]["name"]),
                  subtitle: Text(referedUsers[index]["email"]),
                ),
              ),
            ),
      ),
    );
  }
}

Widget line() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
    height: 1,
    color: Colors.grey,
  );
}
