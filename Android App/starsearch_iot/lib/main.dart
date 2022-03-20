//To run with flutter run --no-sound-null-safety

import 'dart:ui';
import 'package:flutter/material.dart';
import '../Remote ML/RemoteMain.dart';
import '../DB Update/AdminSite.dart';

import './Main/MainScreen.dart';

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
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
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
        DBUpdate.routeName: (context) => DBUpdate(),
        RemoteML.routeName: (context) => RemoteML(),
      },
    );
  }
}
