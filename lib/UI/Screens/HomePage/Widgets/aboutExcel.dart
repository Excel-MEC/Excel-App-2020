import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class AboutExcelPopUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutExcelPopUpState();
}

class AboutExcelPopUpState extends State<AboutExcelPopUp>
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
                Image.asset(
                  "assets/icons/college.png",
                  width: 200,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Excel, the nation’s second and South India’s first ever fest of its kind, was started in 2001 by the students of Govt. Model Engineering College. Over the years, Excel has grown exponentially, consistently playing host to some of the most talented students, the most illustrious speakers and the most reputed companies. Now gearing towards the landmark 21st edition, Excel continues to excite the participants with its wide array of technical and non-technical events and with a promise to live up to its motto. Excel 2020 incorporates a wide variety of technical, managerial and general events which includes competitions, workshops, summits, hackathons, exhibitions and so on.\n\n Join us on 29th, 30th and 31st January 2021 to experience the magic of Excel.",
                    style: TextStyle(
                      color: Color(0xff555566),
                      fontSize: 13,
                      fontFamily: pfontFamily,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/icons/meclogo.png",
                      height: 50,
                    ),
                    Image.asset(
                      "assets/icons/excel2020withtext.png",
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
