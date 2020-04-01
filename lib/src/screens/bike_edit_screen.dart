import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';

import '../blocs/bike_edit_BLoC.dart';
import '../containers/bike_list_container.dart';
import '../keys.dart';
import '../models/app_state.dart';
import '../models/bike_model.dart';
import '../widgets/cards/bike_edit_card.dart';

/// Class that contains the user interface of the Bike Edit view,
/// that is completed by the [BikeEditContainer] class, when relating
/// to central Redux Store and by [BikeEditBloc] to deal with local
/// state management.
/// The `onSaveCallback` function is injected on the [BikeEditBloc.submit]
/// at the [bikeEditCard] widget.
class BikeEditScreen extends StatelessWidget {
  final String lastRouteName;
  final Bike bike;
  final Function onSaveCallback;
  final Function onDeleteCallback;
  final Function onDiscardChangesCallback;
  final Store<AppState> centralStore;

  BikeEditScreen({
    Key key,
    @required this.onSaveCallback,
    @required this.onDeleteCallback,
    @required this.onDiscardChangesCallback,
    this.lastRouteName,
    this.bike,
    this.centralStore,
  }) : super(key: key ?? AppKeys.bikeEditScreen);

  @override
  Widget build(BuildContext context) {
    final bikeEditBloc = BikeEditBloc(bike: bike, store: centralStore);
    return WillPopScope(
      onWillPop: () {
        onWidgetExit(
          context: context,
          bloc: bikeEditBloc,
          item: bike,
          lastRouteName: null,
        );
        return Future<bool>.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Icon(FontAwesomeIcons.bicycle),
          leading: IconButton(
            icon: Platform.isAndroid
                ? Icon(Icons.arrow_back)
                : Icon(Icons.arrow_back_ios),
            tooltip: 'To Bike List',
            onPressed: () {
              onWidgetExit(
                context: context,
                bloc: bikeEditBloc,
                item: bike,
                lastRouteName: null,
              );
            },
          ),
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              bikeEditCard(
                bike: bike,
                context: context,
                bikeEditBloc: bikeEditBloc,
                onSaveCallback: onSaveCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onWidgetExit({
    BuildContext context,
    BikeEditBloc bloc,
    Bike item,
    String lastRouteName,
  }) {
    if (centralStore.state.formDataIsBlank) {
      onDeleteCallback(
        context,
        item.bikeID,
        item.bikeName,
        lastRouteName,
      );
    } else {
      if (centralStore.state.formDataIsModified &&
          (bloc.currentSaveValid ?? false)) {
        onSaveCallback(
          context: context,
          bike: item,
          toBeSaved: item.bikeName,
          lastRouteName: lastRouteName,
          dataIsModified: centralStore.state.formDataIsModified,
        );
      } else {
        if (centralStore.state.formDataIsModified &&
            !(bloc.currentSaveValid ?? false)) {
          onDiscardChangesCallback(
            context: context,
            toBeSaved: item.bikeName,
            lastRouteName: lastRouteName,
            dataIsModified: centralStore.state.formDataIsModified,
          );
        } else {
          if (lastRouteName != null) {
            Navigator.popAndPushNamed(
              context,
              lastRouteName,
            );
          } else {
            Navigator.popAndPushNamed(
              context,
              BikeListContainer.route,
            );
          }
        }
      }
    }
    bloc.dispose();
  }
}
