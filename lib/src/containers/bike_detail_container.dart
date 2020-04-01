import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/bike_actions.dart';
import '../actions/formmod_actions.dart';
import '../containers/bike_edit_container.dart';
import '../models/app_state.dart';
import '../models/bike_model.dart';
import '../screens/bike_detail_screen.dart';
import '../widgets/dialogs/dialog_delete_confirm.dart';

/// Class that contains the business logic of the Bike Detail View,
/// that is completed by the [BikeDetailScreen] class.
class BikeDetailContainer extends StatelessWidget {
  BikeDetailContainer({Key key}) : super(key: key);

  static const String route = '/bikedetail';

  @override
  Widget build(BuildContext context) {
    final String lastRouteName = ModalRoute.of(context).settings.arguments;
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return BikeDetailScreen(
          bike: vm.bike,
          onDeleteCallback: vm.onDeleteCallback,
          onEditCallback: vm.onEditCallback,
          lastRouteName: lastRouteName,
        );
      },
    );
  }
}

class _ViewModel {
  final Bike bike;
  final Function onDeleteCallback;
  final Function onEditCallback;

  _ViewModel({
    this.bike,
    this.onDeleteCallback,
    this.onEditCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      bike: store.state.selectedBike,
      onEditCallback: (
        BuildContext context,
        Bike bike,
      ) {
        store.dispatch(BikeSelectionRequestAction(
          selectedBike: bike,
        ));
        store.dispatch(SetFormDataIsModified(
          formDataIsModified: false,
        ));
        Navigator.popAndPushNamed(
          context,
          BikeEditContainer.route,
          arguments: BikeDetailContainer.route,
        );
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
              return getApproveDelDialogDetailCont(
                context: context,
                store: store,
                approvDeleteDescription: toBeDeleted,
                deleteWarning: '',
                action: BikeDeleteRequestAction(
                  bikeID: bikeID,
                ),
                lastRouteName: lastRouteName,
              );
            });
      },
    );
  }
}
