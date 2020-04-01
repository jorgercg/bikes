import 'package:flutter/material.dart';

/// Item of the [bikeListCard]
class ListItem extends StatelessWidget {
  final Icon icon;
  final String label;
  final String text;

  ListItem({
    @required this.icon,
    @required this.label,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: icon,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:10)),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Item of the [bikeEditCard]
class EditItem extends StatelessWidget {
  final Icon icon;
  final Widget editField;

  EditItem({
    @required this.icon,
    @required this.editField,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: icon,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              editField,
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
