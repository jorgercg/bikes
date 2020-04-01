import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../models/app_state.dart';

/// Helper function used to confirm the save action
AlertDialog getApproveDialogDialogEditCont({
  BuildContext context,
  Store<AppState> store,
  String approvSaveDescription,
  String saveWarning,
  dynamic formDataAction,
  dynamic action,
  String lastRouteName,
  String staticRouteName,
  bool dataIsModified,
}) {
  if ((approvSaveDescription ?? '') == '') {
    approvSaveDescription = 'Item';
  }
  return AlertDialog(
    title: Text(
      'Save?',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    content: Text(
      approvSaveDescription +
          ' ' +
          'will be saved' +
          (saveWarning != '' ? '\n\n' : '') +
          saveWarning,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Icon(Icons.cancel),
        onPressed: () {
          if (dataIsModified == true) {
            store.dispatch(formDataAction);
          }
          if (lastRouteName != null) {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              lastRouteName,
              arguments: lastRouteName,
            );
          } else {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              staticRouteName,
            );
          }
        },
      ),
      FlatButton(
        child: Icon(Icons.check_circle),
        onPressed: () {
          store.dispatch(action);
        },
      ),
    ],
  );
}

/// Helper function used to confirm the discard changes action
AlertDialog getDiscardChangesDialogEditCont({
  BuildContext context,
  Store<AppState> store,
  String approvSaveDescription,
  dynamic formDataAction,
  String lastRouteName,
  String staticRouteName,
  bool dataIsModified,
}) {
  if ((approvSaveDescription ?? '') == '') {
    approvSaveDescription = 'Item';
  }
  return AlertDialog(
    title: Text(
      'Discard Changes?',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    content: Text(
      approvSaveDescription + ' ' + 'changes will not be saved.',
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
      FlatButton(
        child: Icon(Icons.check_circle),
        onPressed: () {
          if (dataIsModified == true) {
            store.dispatch(formDataAction);
          }
          if (lastRouteName != null) {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              lastRouteName,
              arguments: lastRouteName,
            );
          } else {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              staticRouteName,
            );
          }
        },
      ),
    ],
  );
}
