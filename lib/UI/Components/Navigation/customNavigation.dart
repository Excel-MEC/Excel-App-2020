import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import './bottom_navigation.dart';
import './tab_navigator.dart';
import './BottomNavigationBarWidget/layout.dart';

class CustomNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomNavigatorState();
}

class CustomNavigatorState extends State<CustomNavigator> {
  TabItem _currentTab = TabItem.page1;
  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.page1: GlobalKey<NavigatorState>(),
    TabItem.page2: GlobalKey<NavigatorState>(),
    TabItem.page3: GlobalKey<NavigatorState>(),
    TabItem.page4: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.page1) {
            // select 'main' tab
            _selectTab(TabItem.page1);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        extendBody: true,
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.page1),
          _buildOffstageNavigator(TabItem.page2),
          _buildOffstageNavigator(TabItem.page3),
          _buildOffstageNavigator(TabItem.page4),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(context),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

Widget _buildFab(BuildContext context) {
  return AnchoredOverlay(
    showOverlay: false,
    child: FloatingActionButton(
      backgroundColor: Color(0xff252a50),
      onPressed: () {},
      // tooltip: 'Increment',
      child: CachedNetworkImage(
          imageUrl:
              'https://avatars1.githubusercontent.com/u/30120883?s=280&v=4',
          color: Colors.white,
          height: 35),
      elevation: 2.0,
    ),
  );
}
