import 'dart:io';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../actions/bike_actions.dart';
import '../actions/formmod_actions.dart';
import '../containers/bike_edit_container.dart';
import '../containers/bike_list_container.dart';
import '../keys.dart';
import '../models/app_state.dart';
import '../models/bike_model.dart';
import '../storage/bike_storage.dart';
import '../widgets/dialogs/dialog_failed_delete.dart';
import '../widgets/dialogs/dialog_failed_save.dart';

/// Middleware to perform CRUD operations of [bikeList] on a [BikeStorage] class
List<Middleware<AppState>> createBikeMiddleware(BikeStorage bikeStorage) {
  final loadBikeList = _loadBikeListMiddleware(bikeStorage);
  final addBike = _addBikeMiddleware(bikeStorage);
  final deleteBike = _deleteBikeMiddleware(bikeStorage);
  final updateBike = _updateBikeMiddleware(bikeStorage);
  return [
    TypedMiddleware<AppState, LoadBikeListRequestAction>(loadBikeList),
    TypedMiddleware<AppState, BikeAddRequestAction>(addBike),
    TypedMiddleware<AppState, BikeDeleteRequestAction>(deleteBike),
    TypedMiddleware<AppState, BikeUpdateRequestAction>(updateBike),
  ];
}

Middleware<AppState> _loadBikeListMiddleware(BikeStorage bikeStorage) {
  return (Store store, action, NextDispatcher next) async {
    if (action is LoadBikeListRequestAction) {
      store.dispatch(BikeListIsLoadedAction(
        bikeList: await bikeStorage.loadBikeList(),
      ));
      AppKeys.navKey.currentState
          ?.pushNamedAndRemoveUntil(BikeListContainer.route, (_) => false);
    }
    next(action);
  };
}

Middleware<AppState> _addBikeMiddleware(BikeStorage bikeStorage) {
  return (Store store, action, NextDispatcher next) async {
    if (action is BikeAddRequestAction) {
      try {
        Bike bike = Bike(
          bikeID: 0,
          bikeFrameSize: '',
          bikeCategory: '',
          bikeLocation: '',
          bikeName: '',
          bikePhotoURL: '',
          bikePriceRange: '',
          bikeDescription: '',
        );
        dynamic bikeSuccCreated = 'error';
        bikeSuccCreated = await createBike(
          bike: bike,
          store: store,
          bikeStorage: bikeStorage,
        );
        if (bikeSuccCreated is int) {
          bike.bikeID = bikeSuccCreated;
          store.dispatch(BikeSelectionRequestAction(selectedBike: bike));
          store.dispatch(BikeIsAddedAction(selectedBike: bike));
          AppKeys.navKey.currentState?.popAndPushNamed(BikeEditContainer.route);
        } else {
          if (bikeSuccCreated is String) {
            print('Bike add failed: error on createBike operation');
            showDialog(
                context: AppKeys.navKey.currentContext,
                builder: (BuildContext context) {
                  return getFailedCreateDialogPop(
                    context: context,
                    failedDescription: 'Bike',
                  );
                });
          }
        }
      } catch (error) {
        print('Bike add failed: $error');
        showDialog(
            context: AppKeys.navKey.currentContext,
            builder: (BuildContext context) {
              return getFailedCreateDialogPop(
                context: context,
                failedDescription: 'Bike',
              );
            });
      }
    }
    next(action);
  };
}

Future<dynamic> createBike({
  @required Bike bike,
  @required Store store,
  @required BikeStorage bikeStorage,
}) async {
  int newBikeId = 1;
  if (store.state.bikeList.length > 0) {
    List<int> currentBikeListIds =
        store.state.bikeList.map((bike) => bike.bikeID).cast<int>().toList();
    newBikeId = currentBikeListIds.last;
    while (currentBikeListIds.contains(newBikeId)) {
      newBikeId++;
    }
  }
  bike.bikeID = newBikeId;
  dynamic result =
      await bikeStorage.saveBikeList([...store.state.bikeList, bike]);
  if (result is File) {
    return newBikeId;
  } else {
    return result;
  }
}

Middleware<AppState> _deleteBikeMiddleware(BikeStorage bikeStorage) {
  return (Store store, action, NextDispatcher next) async {
    if (action is BikeDeleteRequestAction) {
      try {
        dynamic bikeSuccDeleted = 'error';
        bikeSuccDeleted = await deleteBike(
          bikeID: action.bikeID,
          store: store,
          bikeStorage: bikeStorage,
        );
        if (bikeSuccDeleted is bool) {
          print('Bike deletion successful: $bikeSuccDeleted');
        } else {
          if (bikeSuccDeleted is String) {
            print('Bike deletion failed: error on deleteBike operation');
            showDialog(
                context: AppKeys.navKey.currentContext,
                builder: (BuildContext context) {
                  return getFailedDeleteDialogPop(
                    context: context,
                    failedDescription: store.state.bikelist
                        .where((bike) => bike.bikeID == action.bikeID)
                        .first,
                  );
                });
          }
        }
      } catch (error) {
        print('Bike deletion failed: $error');
        showDialog(
            context: AppKeys.navKey.currentContext,
            builder: (BuildContext context) {
              return getFailedDeleteDialogPop(
                context: context,
                failedDescription: store.state.bikelist
                    .where((bike) => bike.bikeID == action.bikeID)
                    .first,
              );
            });
      }
    }
    next(action);
  };
}

Future<dynamic> deleteBike({
  @required int bikeID,
  @required Store store,
  @required BikeStorage bikeStorage,
}) async {
  dynamic result = await bikeStorage.saveBikeList(store.state.bikeList
      .where((Bike bike) => bike.bikeID != bikeID)
      .toList());

  if (result is File) {
    return true;
  } else {
    return result;
  }
}

Middleware<AppState> _updateBikeMiddleware(BikeStorage bikeStorage) {
  return (Store store, action, NextDispatcher next) async {
    if (action is BikeUpdateRequestAction) {
      bool bikeSuccUpdated = false;
      bikeSuccUpdated = await updateBike(
        bike: action.bike,
        store: store,
        bikeStorage: bikeStorage,
      );
      if (bikeSuccUpdated ?? false) {
        store.dispatch(SetFormDataIsModified(formDataIsModified: false));
        if (action.lastRouteName != null) {
          AppKeys.navKey.currentState?.pop();
          AppKeys.navKey.currentState?.pushReplacementNamed(
            action.lastRouteName,
            arguments: action.lastRouteName,
          );
        } else {
          AppKeys.navKey.currentState?.pop();
          AppKeys.navKey.currentState?.pushReplacementNamed(
            action.staticRouteName,
          );
        }
      } else {
        showDialog(
            context: AppKeys.navKey.currentContext,
            builder: (BuildContext context) {
              return getFailedSaveDialogPop(
                context: context,
                failedDescription: action.bike.bikeName,
                lastRouteName: action.lastRouteName,
                staticRouteName: action.staticRouteName,
              );
            });
      }
    }
    next(action);
  };
}

Future<dynamic> updateBike({
  @required Bike bike,
  @required Store store,
  @required BikeStorage bikeStorage,
}) async {
  try {
    await bikeStorage.saveBikeList(store.state.bikeList
        .map((Bike existingBike) =>
            (existingBike.bikeID == bike.bikeID) ? bike : existingBike)
        .cast<Bike>()
        .toList());
    return true;
  } catch (error) {
    print('Error in updateBike:[$error]');
    return false;
  }
}
