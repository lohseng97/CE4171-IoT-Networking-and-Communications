import 'package:flutter/material.dart';
import './NavigationManager.dart';



// ignore: must_be_immutable
class TabScreen extends StatelessWidget {
  TabScreen(int curPage) {
    this.curPage = curPage - 1;
  }

  late BuildContext context1;
  late int curPage;

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
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.amber,
          icon: Icon(Icons.medical_services),
          label: 'Reminders',
          //activeIcon: Icon(Icons.sim_card),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.green,
          icon: Icon(Icons.local_hospital),
          label: 'Clinics',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.red,
          icon: Icon(Icons.warning),
          label: 'Hazards',
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
