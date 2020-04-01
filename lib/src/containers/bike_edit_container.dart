import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/bike_actions.dart';
import '../actions/formblank_actions.dart';
import '../actions/formmod_actions.dart';
import '../keys.dart';
import '../models/app_state.dart';
import '../models/bike_model.dart';
import '../widgets/dialogs/dialog_delete_confirm.dart';
import '../widgets/dialogs/dialog_save_confirm.dart';
import '../screens/bike_edit_screen.dart';
import './bike_list_container.dart';

/// Class that contains the business logic of the Bike Edit View,
/// relating to the central Redux Store, that is completed 
/// by the [BikeEditScreen] class.
class BikeEditContainer extends StatelessWidget {
  BikeEditContainer({Key key}) : super(key: key);

  static const String route = '/bikeedit';

  @override
  Widget build(BuildContext context) {
    final String lastRouteName = ModalRoute.of(context).settings.arguments;
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.bike == null) {
          return Container();
        } else {
          return BikeEditScreen(
            key: AppKeys.bikeEditScreen,
            lastRouteName: lastRouteName,
            bike: vm.bike,
            onSaveCallback: vm.onSaveCallback,
            onDeleteCallback: vm.onDeleteCallback,
            onDiscardChangesCallback: vm.onDiscardChangesCallback,
            centralStore: vm.centralStore,
          );
        }
      },
    );
  }
}

class _ViewModel {
  final Bike bike;
  final Function onSaveCallback;
  final Function onDeleteCallback;
  final Function onDiscardChangesCallback;
  final Store<AppState> centralStore;

  _ViewModel({
    this.onSaveCallback,
    this.onDeleteCallback,
    this.onDiscardChangesCallback,
    this.bike,
    this.centralStore,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      bike: store.state.selectedBike,
      centralStore: store,
      onSaveCallback: ({
        BuildContext context,
        Bike bike,
        String toBeSaved,
        String lastRouteName,
        bool dataIsModified,
      }) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getApproveDialogDialogEditCont(
                context: context,
                store: store,
                approvSaveDescription: toBeSaved,
                saveWarning: '',
                formDataAction: SetFormDataIsModified(
                  formDataIsModified: false,
                ),
                action: BikeUpdateRequestAction(
                  bike: bike,
                  lastRouteName: lastRouteName,
                  staticRouteName: BikeListContainer.route,
                ),
                lastRouteName: lastRouteName,
                staticRouteName: BikeListContainer.route,
              );
            });
      },
      onDiscardChangesCallback: ({
        BuildContext context,
        String toBeSaved,
        String lastRouteName,
        bool dataIsModified,
      }) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getDiscardChangesDialogEditCont(
                context: context,
                store: store,
                approvSaveDescription: toBeSaved,
                formDataAction: SetFormDataIsModified(
                  formDataIsModified: false,
                ),
                lastRouteName: lastRouteName,
                staticRouteName: BikeListContainer.route,
              );
            });
      },
      onDeleteCallback: (
        BuildContext context,
        int bikeID,
        String toBeDeleted,
        String lastRouteName,
      ) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getApproveDelDialogEditCont(
                context: context,
                store: store,
                approvDeleteDescription: toBeDeleted,
                deleteWarning: '',
                action: BikeDeleteRequestAction(
                  bikeID: bikeID,
                ),
                secondaryAction: SetFormDataIsBlank(
                  formDataIsBlank: true,
                ),
                lastRouteName: lastRouteName,
                staticRouteName: BikeListContainer.route,
              );
            });
      },
    );
  }
}
