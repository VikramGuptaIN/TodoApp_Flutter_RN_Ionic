import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/app_tab.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(tabIconLoader(tab)),
          title: Text(tabTextloader(tab)),
        );
      }).toList(),
    );
  }

  IconData tabIconLoader(activeTab) {
    if (activeTab == AppTab.active) {
      return Icons.local_florist;
    } else if (activeTab == AppTab.completed) {
      return Icons.check;
    } else {
      return Icons.plus_one;
    }
  }

  String tabTextloader(activeTab) {
    if (activeTab == AppTab.active) {
      return 'Active';
    } else if (activeTab == AppTab.completed) {
      return 'Done';
    } else {
      return 'Add';
    }
  }
}
