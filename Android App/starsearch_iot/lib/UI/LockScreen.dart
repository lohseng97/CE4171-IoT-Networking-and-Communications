// TO FIX: AUTHENTICATION ISSUE
// CHANGE BACK ROUTENAME AFTER ISSUE FIXED

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import './MainScreen.dart';

class LockScreen extends StatelessWidget {
  //static const routeName = '/lockscreen';
  static const routeName = '/root';
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: GestureDetector(
          onTap: () async {
            try {
              bool checkBio = await localAuth.canCheckBiometrics;

              if (checkBio) {
                bool authenticated = await localAuth.authenticate(
                    localizedReason:
                        "Authenticate to see your medical history");
                if (authenticated) {
                  Navigator.pushReplacementNamed(
                      context, MainScreenMenu.routeName);
                }
              }
            } on PlatformException catch (e) {
              if (e.code == auth_error.notAvailable)
                Navigator.pushReplacementNamed(
                    context, MainScreenMenu.routeName);
              else if (e.code == auth_error.passcodeNotSet)
                Navigator.pushReplacementNamed(
                    context, MainScreenMenu.routeName);
              else if (e.code == auth_error.notEnrolled)
                Navigator.pushReplacementNamed(
                    context, MainScreenMenu.routeName);
              else if (e.code == auth_error.lockedOut) {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "StarSearch App Login\n\n",
                style: TextStyle(
                    color: Colors.orange,
                    fontFamily: 'RobotoCondensed',
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Icon(
                Icons.fingerprint,
                size: 80.0,
                color: Colors.white,
              ),
              Text(
                "Tap to Login",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RobotoCondensed',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        )));
  }
}