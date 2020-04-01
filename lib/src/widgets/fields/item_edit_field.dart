import 'package:bikes/src/keys.dart';
import 'package:flutter/material.dart';

/// Edit field of the [bikeEditCard]
Widget editField({
  @required String text,
  @required String label,
  @required String hint,
  @required String errorText,
  @required Stream<String> streamField,
  @required Function(String) changeFunctionField,
}) {
  return StreamBuilder<String>(
    key: AppKeys.bikeEditLineItem(label),
    stream: streamField,
    builder: (context, snapshot) {
      return TextFormField(
        onChanged: changeFunctionField,
        obscureText: false,
        initialValue: text,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          errorText: snapshot.error != null ? errorText : null,
        ),
      );
    },
  );
}
