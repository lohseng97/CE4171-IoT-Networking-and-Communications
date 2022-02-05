import 'package:flutter/material.dart';

void aboutUs(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('About Us'),
      content: Text('Designed by: StarSearch\nVersion: 1.0.1'),
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
