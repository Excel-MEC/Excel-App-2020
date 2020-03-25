import './../BottomNavigationBar/fab_bottom_app_bar.dart';
import './../bottomNavigationBar/layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // It determines the selected index
  int bottomBarSelectedIndex = 0;

  // Bottom navigation bar chooses the page to be loaded.
  void _selectedTab(int index) {
    setState(() {
      bottomBarSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body uses the function to find which page has to be displayed.
      body: findPage(bottomBarSelectedIndex, context),
      // The following code defines Bottom Navigation Bar.
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: '',
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: ''),
          FABBottomAppBarItem(iconData: Icons.list, text: ''),
          FABBottomAppBarItem(iconData: Icons.favorite, text: ''),
          FABBottomAppBarItem(iconData: Icons.radio_button_checked, text: ''),
        ],
      ),
      // Floating Action Button is specified
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildFab(BuildContext context) {
    return AnchoredOverlay(
      showOverlay: false,
      child: FloatingActionButton(
        onPressed: () {},
        // tooltip: 'Increment',
        child: Icon(Icons.eject),
        elevation: 2.0,
      ),
    );
  }
}

Widget findPage(index, context) {
  // Sample Pages that can be replaced by importing pages when it is ready.
  Widget page1 = Scaffold(
    body: Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 32.0),
      ),
    ),
  );

  Widget page2 = Scaffold(
    body: Center(
      child: Text(
        'Lists Page',
        style: TextStyle(fontSize: 32.0),
      ),
    ),
  );

  Widget page3 = Scaffold(
    body: Center(
      child: Text(
        'Registered Page',
        style: TextStyle(fontSize: 32.0),
      ),
    ),
  );

  Widget page4 = Scaffold(
    body: Center(
      child: Text(
        '4rth Page',
        style: TextStyle(fontSize: 32.0),
      ),
    ),
  );

// Returns required page by checking index
  switch (index) {
    case 0:
      return page1;
      break;
    case 1:
      return page2;
      break;
    case 2:
      return page3;
      break;
    case 3:
      return page4;
      break;
    default:
      return Center();
  }
}
