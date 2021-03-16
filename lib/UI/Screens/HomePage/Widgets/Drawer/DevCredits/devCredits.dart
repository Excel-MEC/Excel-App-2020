import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class DevCredits extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DevCreditsState();
}

class DevCreditsState extends State<DevCredits>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  var developers = [
    {
      "name": "Steev James",
      "email": "steev.james11@gmail.com",
      "image": "assets/devs/steev.jpg"
    },
    {
      "name": "Joyal A Johney",
      "email": "joyalajohny@gmail.com",
      "image": "assets/devs/joyal.jpg"
    },
    {
      "name": "Ajesh Kumar",
      "email": "ajeshkumar.mec@gmail.com",
      "image": "assets/devs/ajesh.jpg"
    },
    {
      "name": "Priyanga P Kini",
      "email": "priyangapkini99@gmail.com",
      "image": "assets/devs/priyanka.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        insetPadding: EdgeInsets.all(13),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Core Developers",
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    fontFamily: pfontFamily,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  "assets/divider.png",
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[] +
                      List.generate(
                        developers.length,
                        (index) => Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          // color: Colors.red,
                          child: ListTile(
                            title: Text(
                              developers[index]["name"],
                              style: TextStyle(fontSize: 14.5),
                            ),
                            subtitle: Text(
                              developers[index]["email"],
                              style: TextStyle(fontSize: 13),
                            ),
                            dense: true,
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                developers[index]["image"],
                              ),
                            ),
                          ),
                        ),
                      ) +
                      [SizedBox(height: 10)],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
