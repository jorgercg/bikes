import 'package:flutter/material.dart';

/// Helper function used to show user that
/// the delete action has failed.
AlertDialog getFailedDeleteDialogPop({
  BuildContext context,
  String failedDescription,
}) {
  if ((failedDescription ?? '') == '') {
    failedDescription = 'Item';
  }
  return AlertDialog(
    title: Text(
      'Delete Failed',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    content: Text(
      failedDescription +
          ' ' +
          'was not deleted',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Icon(Icons.cancel),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
