import 'dart:ui';
import 'package:flutter/material.dart';

import './UI/MainScreen.dart';
import './UI/LockScreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSearch',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
          canvasColor: Colors.black,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(10, 21, 21, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(10, 21, 21, 1),
                ),
                headline6: TextStyle(
                  fontSize: 21,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
      ),
      initialRoute: '/root',
        routes: {
          MainScreenMenu.routeName: (context) => MainScreenMenu(),
          LockScreen.routeName: (context) => LockScreen(),
        },
    );
  }
}