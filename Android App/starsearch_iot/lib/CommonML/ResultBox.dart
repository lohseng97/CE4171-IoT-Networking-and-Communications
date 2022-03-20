import 'package:flutter/material.dart';

class ResultBox {
  static defaultPrompt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Text(
        'Upload Image to get Prediction',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'RobotoCondensed',
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.withOpacity(0.8),
            Colors.pinkAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  static connecting(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Text(
        'Connecting to Server...',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'RobotoCondensed',
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.withOpacity(0.8),
            Colors.pinkAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  static noConnectionError(BuildContext context, var errorCode, var errorText) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Text(
        errorCode + errorText,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'RobotoCondensed',
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.withOpacity(0.8),
            Colors.pinkAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  static snapshotError(BuildContext context, var snapshot) {
    return Container(
        padding: const EdgeInsets.all(25),
        child: Text(
          'Error Detected. \nError:${snapshot.error}',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoCondensed',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.8),
              Colors.deepPurpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ));
  }

  static snapShotOutput(
      BuildContext context, var score, var title, var time, var prediction) {
    return Container(
        padding: const EdgeInsets.all(25),
        child: Text(
          'Predicted Class: $prediction. Accuracy: $score. Title: $title. Time of submission: $time.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoCondensed',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.8),
              Colors.deepPurpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
