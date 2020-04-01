import 'package:flutter/material.dart';

/// Helper function used to show the user that
/// the save action has failed
AlertDialog getFailedSaveDialogPop({
  BuildContext context,
  String failedDescription,
  String lastRouteName,
  String staticRouteName,
}) {
  if ((failedDescription ?? '') == '') {
    failedDescription = 'Item';
  }
  return AlertDialog(
    title: Text(
      'Save Failed',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    content: Text(
      failedDescription + ' ' + 'was not saved',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Icon(Icons.cancel),
        onPressed: () {
          if (lastRouteName != null) {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              lastRouteName,
              arguments: lastRouteName,
            );
          } else {
            Navigator.of(context).pop();
            if (staticRouteName != null) {
              Navigator.pushReplacementNamed(
                context,
                staticRouteName,
              );
            }
          }
        },
      ),
    ],
  );
}

/// Helper function used to show the user that
/// the create action has failed
AlertDialog getFailedCreateDialogPop({
  BuildContext context,
  String failedDescription,
  String lastRouteName,
  String staticRouteName,
}) {
  if ((failedDescription ?? '') == '') {
    failedDescription = 'Item';
  }
  return AlertDialog(
    title: Text(
      'Create Failed',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    content: Text(
      failedDescription + ' ' + 'was not created',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Icon(Icons.cancel),
        onPressed: () {
          if (lastRouteName != null) {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              lastRouteName,
              arguments: lastRouteName,
            );
          } else {
            Navigator.of(context).pop();
            if (staticRouteName != null) {
              Navigator.pushReplacementNamed(
                context,
                staticRouteName,
              );
            }
          }
        },
      ),
    ],
  );
}
