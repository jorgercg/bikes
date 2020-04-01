import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/bike_actions.dart';
import '../actions/formblank_actions.dart';
import '../actions/formmod_actions.dart';
import '../containers/bike_detail_container.dart';
import '../containers/bike_edit_container.dart';
import '../models/app_state.dart';
import '../models/bike_model.dart';
import '../screens/bike_list_screen.dart';
import '../widgets/dialogs/dialog_delete_confirm.dart';

/// Class that contains the business logic of the Bike List View,
/// that is completed by the [BikeListScreen] class.
class BikeListContainer extends StatelessWidget {
  BikeListContainer({Key key}) : super(key: key);

  static const String route = '/bikelist';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return BikeListScreen(
          bikeList: vm.bikeList ?? [],
          onAddCallback: vm.onAddCallback,
          onDeleteCallback: vm.onDeleteCallback,
          onDetailCallback: vm.onDetailCallback,
          onEditCallback: vm.onEditCallback,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Bike> bikeList;
  final Function onAddCallback;
  final Function onDeleteCallback;
  final Function onDetailCallback;
  final Function onEditCallback;

  _ViewModel({
    this.bikeList,
    this.onAddCallback,
    this.onDeleteCallback,
    this.onDetailCallback,
    this.onEditCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      bikeList: store.state.bikeList,
      onAddCallback: (BuildContext context) {
        store.dispatch(SetFormDataIsBlank(
          formDataIsBlank: true,
        ));
        store.dispatch(BikeAddRequestAction());
      },
      onDetailCallback: (BuildContext context, Bike bike) {
        store.dispatch(BikeSelectionRequestAction(
          selectedBike: bike,
        ));
        Navigator.popAndPushNamed(
          context,
          BikeDetailContainer.route,
          arguments: BikeListContainer.route,
        );
      },
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
          arguments: BikeListContainer.route,
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
              return getApproveDelDialogListCont(
                context: context,
                store: store,
                approvDeleteDescription: toBeDeleted,
                deleteWarning: '',
                action: BikeDeleteRequestAction(
                  bikeID: bikeID,
                ),
              );
            });
      },
    );
  }
}
