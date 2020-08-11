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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
              Text(
                referedUsers.isEmpty
                    ? "No refered users"
                    : "Your referals:\n\n",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Color(0xaa000000)),
              )
            ] +
            List.generate(
              referedUsers.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(referedUsers[index]["name"]),
                  Text(referedUsers[index]["email"]),
                  Text(referedUsers[index]["isPaid"]
                      ? "Is"
                      : "Is not" + " a paid user\n\n"),
                ],
              ),
            ),
      ),
    );
  }
}
