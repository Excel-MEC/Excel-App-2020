import 'package:flutter/material.dart';
import './BottomNavigationBarWidget/fab_bottom_app_bar.dart';

enum TabItem { page1, page2, page3, page4 }

Map<TabItem, int> tabName = {
  TabItem.page1: 0,
  TabItem.page2: 1,
  TabItem.page3: 2,
  TabItem.page4: 3,
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return FABBottomAppBar(
      centerItemText: '',
      color: Colors.grey,
      selectedColor: Color(0xff252a50),
      notchedShape: CircularNotchedRectangle(),
      onTabSelected: (index) => onSelectTab(
        TabItem.values[index],
      ),
      items: [
        FABBottomAppBarItem(iconData: Icons.home, text: ''),
        FABBottomAppBarItem(iconData: Icons.list, text: ''),
        FABBottomAppBarItem(iconData: Icons.favorite, text: ''),
        FABBottomAppBarItem(iconData: Icons.account_circle, text: ''),
      ],
    );
  }


}
