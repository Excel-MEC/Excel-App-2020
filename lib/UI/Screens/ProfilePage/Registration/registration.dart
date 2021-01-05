import 'package:excelapp/Services/API/registration_api.dart';
import 'package:excelapp/UI/Components/LoadingUI/loadingAnimation.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/UI/Components/Appbar/appbar.dart';
import 'package:excelapp/UI/Components/EventCard/event_card.dart';

class RegisteredEvents extends StatefulWidget {
  RegisteredEvents();

  @override
  _RegisteredEventsState createState() => _RegisteredEventsState();
}

class _RegisteredEventsState extends State<RegisteredEvents> {
  Future registrationList;
  @override
  void initState() {
    registrationList = RegistrationAPI.fetchRegistrations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Registered'),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: registrationList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == "error") {
                    return Center(child: Text("An error occured, Try again"));
                  }
                  // If no data is obtained from API
                  List<Event> list = snapshot.data;
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text(
                        "No Events\n\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EventCard(list[index]);
                    },
                  );
                } else {
                  return LoadingAnimation();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
