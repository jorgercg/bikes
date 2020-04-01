import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../containers/bike_list_container.dart';
import '../models/bike_model.dart';
import '../widgets/cards/bike_list_card.dart';

/// Class that contains the user interface of the Bike Detail View,
/// that is completed by the [BikeDetailContainer] class.
class BikeDetailScreen extends StatelessWidget {
  final Bike bike;
  final Function onDeleteCallback;
  final Function onEditCallback;
  final String lastRouteName;

  BikeDetailScreen({
    @required this.bike,
    @required this.onDeleteCallback,
    @required this.onEditCallback,
    @required this.lastRouteName,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(
          context,
          BikeListContainer.route,
        );
        return Future<bool>.value(false);
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Icon(FontAwesomeIcons.bicycle),
              leading: IconButton(
                icon: Platform.isAndroid
                    ? Icon(Icons.arrow_back)
                    : Icon(Icons.arrow_back_ios),
                tooltip: 'To Bike List',
                onPressed: () {
                  Navigator.popAndPushNamed(
                    context,
                    BikeListContainer.route,
                  );
                },
              ),
            ),
            body: Container(
              color: Colors.grey[200],
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  bikeListCard(
                    bike: bike,
                    context: context,
                    onEditCallback: onEditCallback,
                    onDeleteCallback: onDeleteCallback,
                    isDetailCard: true,
                    lastRouteName: lastRouteName,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
