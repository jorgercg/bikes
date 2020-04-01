import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Helper function used to deal with the Android's
/// back button on the app central screen.
AlertDialog getExitAppDialog({
  BuildContext context,
}) {
  return AlertDialog(
    title: Text(
      'Exit?',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Icon(Icons.cancel),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      FlatButton(
        child: Icon(Icons.check_circle),
        onPressed: () {
          SystemNavigator.pop();
        },
      ),
    ],
  );
}
