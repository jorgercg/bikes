import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../models/bike_model.dart';
import '../widgets/cards/bike_list_card.dart';
import '../widgets/dialogs/dialog_exit_app.dart';
import '../widgets/other/empty_list_widget.dart';

/// Class that contains the user interface of the Bike List view,
/// that is completed by the [BikeListContainer] class.
class BikeListScreen extends StatelessWidget {
  final List<Bike> bikeList;
  final Function onAddCallback;
  final Function onDeleteCallback;
  final Function onDetailCallback;
  final Function onEditCallback;

  BikeListScreen({
    this.bikeList,
    this.onAddCallback,
    this.onDeleteCallback,
    this.onDetailCallback,
    this.onEditCallback,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getExitAppDialog(context: context);
            });
        return Future<bool>.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(appTitle),
          ),
          body: bikeList.length > 0
              ? Container(
                  color: Colors.grey[200],
                  child: ListView.builder(
                    itemCount: bikeList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => onDetailCallback(
                          context,
                          bikeList[index],
                        ),
                        child: bikeListCard(
                          bike: bikeList[index],
                          context: context,
                          onDeleteCallback: onDeleteCallback,
                          onEditCallback: onEditCallback,
                          isLastCard: index == (bikeList.length - 1),
                        ),
                      );
                    },
                  ),
                )
              : listIsEmpty(context: context),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => onAddCallback(context),
            icon: Icon(Icons.add),
            label: FaIcon(FontAwesomeIcons.bicycle),
          ),
        ),
      ),
    );
  }
}
