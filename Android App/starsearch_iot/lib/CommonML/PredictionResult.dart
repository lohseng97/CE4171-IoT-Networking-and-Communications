import 'package:flutter/material.dart';

void predictionResult(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Prediction Result'),
      content: Text('Testing'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
          child: Text('OK'),
        )
      ],
    ),
  );
}
