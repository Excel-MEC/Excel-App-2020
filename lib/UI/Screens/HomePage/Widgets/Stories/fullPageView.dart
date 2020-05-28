import 'package:cached_network_image/cached_network_image.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';

class FullPageView extends StatefulWidget {
  final List<Map<String, dynamic>> storiesMapList;
  final int selectedIndex;

  FullPageView(
      {Key key, @required this.storiesMapList, @required this.selectedIndex})
      : super(key: key);
  @override
  FullPageViewState createState() =>
      FullPageViewState(storiesMapList, selectedIndex);
}

class FullPageViewState extends State<FullPageView> {
  final List<Map<String, dynamic>> storiesMapList;
  int selectedIndex;
  FullPageViewState(this.storiesMapList, this.selectedIndex);

  PageController _pageController;

  nextPage(index) {
    if (index == storiesMapList.length - 1) Navigator.pop(context);
    setState(() {
      selectedIndex = index + 1;
    });

    _pageController.animateToPage(selectedIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  prevPage(index) {
    if (index == 0) return;
    setState(() {
      selectedIndex = index - 1;
    });
    _pageController.animateToPage(selectedIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: selectedIndex);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (page) {
              selectedIndex = page;
            },
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              storiesMapList.length,
              (index) => Stack(
                children: <Widget>[
                  Scaffold(
                    body: Hero(
                      tag: 'story' + selectedIndex.toString(),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              storiesMapList[index]['image'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Overlay to detect taps for next page & previous page
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            prevPage(index);
                          },
                          child: Center(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            nextPage(index);
                          },
                          child: Center(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Status number indicator
          Column(
            children: <Widget>[
              SafeArea(child: Center()),
              Row(
                children: List.generate(
                  storiesMapList.length,
                  (index) => Expanded(
                    child: Container(
                      margin: EdgeInsets.all(2),
                      height: 2.5,
                      decoration: BoxDecoration(
                          color: index > selectedIndex
                              ? Colors.white
                              : Color(0xff999999),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(blurRadius: 2, color: primaryColor)
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
