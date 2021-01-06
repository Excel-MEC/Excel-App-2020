import 'package:excelapp/UI/Screens/HomePage/Widgets/aboutExcel.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import './bottom_navigation.dart';
import './tab_navigator.dart';
import './BottomNavigationBarWidget/layout.dart';

// To add pages to Bottom Navigation Bar, import & add them to /lib/UI/Components/Navigation/pageNavigator.dart

// To hide bottom navigatiom bar, import this file and call hideBottomNav()
// To show bottom navigatiom bar, import this file and call showBottomNav()

Function hideBottomNav;
Function showBottomNav;

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

  bool bottonNavHidden = false;

  @protected
  void initState() {
    hideBottomNav = () {
      setState(() {
        bottonNavHidden = true;
      });
    };
    showBottomNav = () {
      setState(() {
        bottonNavHidden = false;
      });
    };
    super.initState();
  }

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
        bottomNavigationBar: Visibility(
          maintainState: true,
          visible: bottonNavHidden ? false : true,
          child: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(context, bottonNavHidden),
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

Widget _buildFab(BuildContext context, bottonNavHidden) {
  return Visibility(
    maintainState: true,
    visible: bottonNavHidden ? false : true,
    child: AnchoredOverlay(
      showOverlay: false,
      child: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AboutExcelPopUp();
            },
          );
        },
        child: Image.asset(
          'assets/excel logo.png',
          height: 37,
          color: Colors.white,
        ),
        elevation: 2.0,
      ),
    ),
  );
}
