import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void exitApp(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Exit App'),
      content: Text('Do you want to exit StarSearch?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: Text('Yes'),
        )
      ],
    ),
  );
}
