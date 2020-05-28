import 'package:cached_network_image/cached_network_image.dart';
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
  final int selectedIndex;
  FullPageViewState(this.storiesMapList, this.selectedIndex);
  PageController _pageController;
  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: selectedIndex);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              storiesMapList.length,
              (index) => Scaffold(
                body: Container(
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
          )
        ],
      ),
    );
  }
}
