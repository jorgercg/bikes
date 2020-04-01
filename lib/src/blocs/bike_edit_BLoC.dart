import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

import '../actions/bike_actions.dart';
import '../actions/formblank_actions.dart';
import '../actions/formmod_actions.dart';
import '../models/app_state.dart';
import '../models/bike_model.dart';

/// This class has all the local state logic of the [BikeEditEscreen],
/// using RxDart all validation is made and the updates of the 
/// app central state is done with the [BikeSelectedUpdateRequestAction]
/// and then submitted when all is done, using the callback function
/// injected by [BikeEditEscreen]. 
class BikeEditBloc {
  final BehaviorSubject<String> _nameController;
  final BehaviorSubject<String> _frameSizeController;
  final BehaviorSubject<String> _categoryController;
  final BehaviorSubject<String> _locationController;
  final BehaviorSubject<String> _photoURLController;
  final BehaviorSubject<String> _priceRangeController;
  final BehaviorSubject<String> _descriptionController;
  final Store<AppState> _store;
  final Bike _bike;
  bool currentSaveValid = false;

  BikeEditBloc({
    @required Bike bike,
    @required Store<AppState> store,
  })  : _nameController =
            BehaviorSubject<String>.seeded(store.state.selectedBike.bikeName),
        _frameSizeController = BehaviorSubject<String>.seeded(
            store.state.selectedBike.bikeFrameSize),
        _categoryController = BehaviorSubject<String>.seeded(
            store.state.selectedBike.bikeCategory),
        _locationController = BehaviorSubject<String>.seeded(
            store.state.selectedBike.bikeLocation),
        _photoURLController = BehaviorSubject<String>.seeded(
            store.state.selectedBike.bikePhotoURL),
        _priceRangeController = BehaviorSubject<String>.seeded(
            store.state.selectedBike.bikePriceRange),
        _descriptionController = BehaviorSubject<String>.seeded(
            store.state.selectedBike.bikeDescription),
        _bike = bike,
        _store = store;

  //Add data to the stream
  Stream<String> get name => _nameController.stream;
  Stream<String> get frameSize => _frameSizeController.stream;
  Stream<String> get category => _categoryController.stream;
  Stream<String> get location => _locationController.stream;
  Stream<String> get photoURL => _photoURLController.stream;
  Stream<String> get priceRange => _priceRangeController.stream;
  Stream<String> get description => _descriptionController.stream;
  Stream<bool> get saveValid => Rx.combineLatest7(name, frameSize, category,
          location, photoURL, priceRange, description, (
        name,
        frameSize,
        category,
        location,
        photoURL,
        priceRange,
        description,
      ) {
        // If something is changed dispatch it to the store
        if (!(name == _store.state.selectedBike.bikeName) ||
            !(frameSize == _store.state.selectedBike.bikeFrameSize) ||
            !(category == _store.state.selectedBike.bikeCategory) ||
            !(location == _store.state.selectedBike.bikeLocation) ||
            !(photoURL == _store.state.selectedBike.bikePhotoURL) ||
            !(priceRange == _store.state.selectedBike.bikePriceRange) ||
            !(description == _store.state.selectedBike.bikeDescription)) {
          _store.dispatch(SetFormDataIsModified(formDataIsModified: true));
          if (_store.state.formDataIsBlank == true) {
            _store.dispatch(SetFormDataIsBlank(formDataIsBlank: false));
          }
          _store.dispatch(
            BikeSelectedUpdateRequestAction(
              selectedBike: Bike(
                bikeID: _bike.bikeID,
                bikeName: name,
                bikeFrameSize: frameSize,
                bikeCategory: category,
                bikeLocation: location,
                bikePhotoURL: photoURL,
                bikePriceRange: priceRange,
                bikeDescription: description,
              ),
            ),
          );
        }
        // Verify validators
        if ((name.length > 3) &&
            (name.length < 51) &&
            (frameSize.length > 0) &&
            (frameSize.length < 2) &&
            (category.length > 3) &&
            (category.length < 51) &&
            (location.length > 3) &&
            (location.length < 51) &&
            (photoURL.length > 3) &&
            (photoURL.length < 256) &&
            (priceRange.length > 3) &&
            (priceRange.length < 51) &&
            (description.length > 3) &&
            (description.length < 101)) {
          currentSaveValid = true;
          return true;
        }
        // Add the error in the correct sink
        // bikeName
        if ((name.length < 4) || (name.length > 50))
          _nameController.sink.addError(' ');
        // bikeFrameSize
        if ((frameSize.length < 1) || (frameSize.length > 1))
          _frameSizeController.sink.addError(' ');
        // bikeCategory
        if ((category.length < 4) || (category.length > 50))
          _categoryController.sink.addError(' ');
        // bikeLocation
        if ((location.length < 4) || (location.length > 50))
          _locationController.sink.addError(' ');
        // bikePhotoURL
        if ((photoURL.length < 4) || (photoURL.length > 255))
          _photoURLController.sink.addError(' ');
        // bikePriceRange
        if ((priceRange.length < 4) || (priceRange.length > 50))
          _priceRangeController.sink.addError(' ');
        // bikeDescription
        if ((description.length < 4) || (description.length > 100))
          _descriptionController.sink.addError(' ');
        currentSaveValid = false;
        return false;
      });

  //Change data
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeFrameSize => _frameSizeController.sink.add;
  Function(String) get changeCategory => _categoryController.sink.add;
  Function(String) get changeLocation => _locationController.sink.add;
  Function(String) get changePhotoURL => _photoURLController.sink.add;
  Function(String) get changePriceRange => _priceRangeController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;

  //Submit when done
  submit(
    Function callback,
    BuildContext context,
    String lastRouteName,
    bool dataIsModified,
  ) {
    callback(
      context: context,
      bike: _store.state.selectedBike,
      lastRouteName: lastRouteName,
      toBeSaved: _nameController.value,
      dataIsModified: dataIsModified,
    );
  }

  dispose() {
    _nameController?.close();
    _frameSizeController?.close();
    _categoryController?.close();
    _locationController?.close();
    _photoURLController?.close();
    _priceRangeController?.close();
    _descriptionController?.close();
  }
}
