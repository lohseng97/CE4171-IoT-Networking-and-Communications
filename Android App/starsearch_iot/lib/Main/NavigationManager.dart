import 'package:flutter/material.dart';
import '../Remote ML/RemoteMain.dart';
import '../DB Update/AdminSite.dart';

import './MainScreen.dart';
import './side_panel/AboutUs.dart';
import './side_panel/ExitApp.dart';
import '../Local ML/LocalMain.dart';
import '../Remote ML/RemoteNoImage.dart';

class NavigationManager {
  static void drawerPageIndex(BuildContext context, int curPage) {
    if (curPage >= 1 && curPage <= 4) {
      allNavigation(context, curPage);
    } else if (curPage == 5) {
      exitApp(context);
    } else if (curPage == 6) {
      aboutUs(context);
    }
  }

  static void mainMenuIndex(BuildContext context, int curPage) {
    if (curPage >= 1 && curPage <= 4) {
      allNavigation(context, curPage);
    }
  }

  static void tabIndex(BuildContext context, int curPage) {
    if (curPage >= 1 && curPage <= 4) {
      allNavigation(context, curPage);
    } else if (curPage == 5) {
      exitApp(context);
    }
  }

  static void allNavigation(BuildContext context, int curPage) {
    if (curPage == 1) {
      Navigator.of(context).pushReplacementNamed(MainScreenMenu.routeName);
    } else if (curPage == 2) {
      Navigator.of(context).pushReplacementNamed(LocalML.routeName);
    } else if (curPage == 3) {
      Navigator.of(context).pushReplacementNamed(RemoteML.routeName);
    } else if (curPage == 4) {
      Navigator.of(context).pushReplacementNamed(DBUpdate.routeName);
    }
  }

  static void remoteImageError(BuildContext context) {
    noImageError(context);
  }
}
