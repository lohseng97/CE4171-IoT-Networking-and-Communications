// TO FIX: LOCKSCREEN BUG
// CHANGE BACK TO /main after issue fixed

import 'package:flutter/material.dart';

import 'Drawer.dart';
import './TabScreen.dart';
import './NavigationManager.dart';

class MainScreenMenu extends StatelessWidget {
  static const routeName = '/root';

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Home Page",
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Raleway',
            ),
          ),
        ),
        drawer: MainDrawer(),
        bottomNavigationBar: TabScreen(1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    NavigationManager.mainMenuIndex(context, 2);
                  },
                  splashColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        'Remote Machine Learning',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                InkWell(
                  onTap: () {
                    NavigationManager.mainMenuIndex(context, 3);
                  },
                  splashColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        'Database Update',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
