import 'package:flutter/material.dart';
import './NavigationManager.dart';

// ignore: must_be_immutable
class TabScreen extends StatelessWidget {
  TabScreen(int curPage) {
    this.curPage = curPage - 1;
  }

  BuildContext context1;
  int curPage;

  void _curPage(int index) {
    index++;
    NavigationManager.tabIndex(context1, index);
  }

  @override
  Widget build(BuildContext context) {
    context1 = context;

    return BottomNavigationBar(
      onTap: _curPage,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.black,
      selectedFontSize: 15,
      unselectedFontSize: 12,
      currentIndex: curPage,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.orange,
          icon: Icon(Icons.settings_remote),
          label: 'Remote ML',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.red,
          icon: Icon(Icons.exit_to_app_sharp),
          label: 'Exit',
        ),
      ],
    );
  }
}
