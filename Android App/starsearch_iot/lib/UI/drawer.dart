import 'package:flutter/material.dart';

import './NavigationManager.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(25),
            alignment: Alignment.centerLeft,
            color: Colors.orange,
            child: Text(
              'Welcome to Health Zone!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
              leading: Icon(Icons.home, color: Colors.orange, size: 25),
              title: Text(
                'Home Page',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RobotoCondensed',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                NavigationManager.drawerPageIndex(context, 1);
              }),
          ListTile(
            leading: Icon(Icons.medical_services, color: Colors.cyan, size: 22),
            title: Text(
              'Medical Services',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RobotoCondensed',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              NavigationManager.drawerPageIndex(context, 2);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_hospital, color: Colors.white, size: 22),
            title: Text(
              'CHAS Clinics',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RobotoCondensed',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              NavigationManager.drawerPageIndex(context, 3);
            },
          ),
          ListTile(
            leading: Icon(Icons.warning, color: Colors.red, size: 22),
            title: Text(
              'Health Hazards',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RobotoCondensed',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              NavigationManager.drawerPageIndex(context, 4);
            },
          ),
          ListTile(
            leading:
                Icon(Icons.exit_to_app, color: Colors.deepPurple, size: 20),
            title: Text(
              'Exit',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'RobotoCondensed',
                fontSize: 16,
              ),
            ),
            onTap: () {
              NavigationManager.drawerPageIndex(context, 5);
            },
          ),
          ListTile(
              leading:
                  Icon(Icons.build_circle, color: Colors.white70, size: 20),
              title: Text(
                'About Us',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RobotoCondensed',
                    fontSize: 16),
              ),
              onTap: () {
                NavigationManager.drawerPageIndex(context, 6);
              }),
        ],
      ),
    );
  }
}
