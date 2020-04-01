import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../models/app_state.dart';

/// Helper function used to confirm the delete action
/// on the List Container
AlertDialog getApproveDelDialogListCont({
  BuildContext context,
  Store<AppState> store,
  String approvDeleteDescription,
  String deleteWarning,
  dynamic action,
}) {
  if ((approvDeleteDescription ?? '') == '') {
    approvDeleteDescription = 'Item';
  }
  return AlertDialog(
    title: Text(
      'Delete?',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    content: Text(
      approvDeleteDescription +
          ' ' +
          'will be deleted' +
          (deleteWarning != '' ? '\n\n' : '') +
          deleteWarning,
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
          store.dispatch(action);
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

/// Helper function used to confirm the delete action
/// on the Edit Container
AlertDialog getApproveDelDialogEditCont({
  BuildContext context,
  Store<AppState> store,
  String approvDeleteDescription,
  String deleteWarning,
  dynamic action,
  dynamic secondaryAction,
  String lastRouteName,
  String staticRouteName,
}) {
  if ((approvDeleteDescription ?? '') == '') {
    approvDeleteDescription = 'Item';
  }
  return AlertDialog(
    title: Text(
      'Delete?',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    content: Text(
      approvDeleteDescription +
          ' ' +
          'will be deleted' +
          (deleteWarning != '' ? '\n\n' : '') +
          deleteWarning,
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
          store.dispatch(action);
          if (secondaryAction != null) {
            store.dispatch(secondaryAction);
          }
          if (lastRouteName != null) {
            Navigator.of(context).pop();
            Navigator.popAndPushNamed(
              context,
              lastRouteName,
              arguments: lastRouteName,
            );
          } else {
            Navigator.of(context).pop();
            Navigator.popAndPushNamed(
              context,
              staticRouteName,
            );
          }
        },
      ),
    ],
  );
}

AlertDialog getApproveDelDialogDetailCont({
  BuildContext context,
  Store<AppState> store,
  String approvDeleteDescription,
  String deleteWarning,
  dynamic action,
  String lastRouteName,
}) {
  if ((approvDeleteDescription ?? '') == '') {
    approvDeleteDescription = 'Item';
  }
  return AlertDialog(
    title: Text(
      'Delete?',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    ),
    content: Text(
      approvDeleteDescription +
          ' ' +
          'will be deleted' +
          (deleteWarning != '' ? '\n\n' : '') +
          deleteWarning,
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
          store.dispatch(action);
          Navigator.of(context).pushNamedAndRemoveUntil(
            lastRouteName,
            (_) => false,
          );
        },
      ),
    ],
  );
}
