import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullPageView extends StatefulWidget {
  final List<Map<String, dynamic>> storiesMapList;

  FullPageView({Key key, @required this.storiesMapList}) : super(key: key);
  @override
  FullPageViewState createState() => FullPageViewState(storiesMapList);
}

class FullPageViewState extends State<FullPageView> {
  final storiesMapList;
  FullPageViewState(this.storiesMapList);
  PageController _pageController;
  @override
  Widget build(BuildContext context) {
    _pageController = PageController();
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
