import 'package:flutter/material.dart';

import '../models/bike_model.dart';

class LoadBikeListRequestAction {
  LoadBikeListRequestAction();

  @override
  String toString() {
    return 'LoadBikeListRequestAction {}';
  }
}

class BikeListIsLoadedAction {
  final List<Bike> bikeList;

  BikeListIsLoadedAction({
    @required this.bikeList,
  });

  @override
  String toString() {
    return 'BikeListIsLoadedAction {bikeList.length: ${bikeList.length}';
  }
}

class BikeAddRequestAction {
  BikeAddRequestAction();

  @override
  String toString() {
    return 'BikeAddRequestAction {}';
  }
}

class BikeIsAddedAction {
  final Bike selectedBike;

  BikeIsAddedAction({
    @required this.selectedBike,
  });

  @override
  String toString() {
    return 'BikeIsAddedAction {bikeID: ${selectedBike.bikeID}}';
  }
}

class BikeSelectionRequestAction {
  final Bike selectedBike;

  BikeSelectionRequestAction({
    @required this.selectedBike,
  });

  @override
  String toString() {
    return 'BikeSelectionRequestAction {bikeID: ${selectedBike.bikeID}}';
  }
}

class BikeSelectedUpdateRequestAction {
  final Bike selectedBike;

  BikeSelectedUpdateRequestAction({
    @required this.selectedBike,
  });

  @override
  String toString() {
    return 'BikeSelectedUpdateRequestAction {bikeID: ${selectedBike.bikeID}}';
  }
}

class BikeUpdateRequestAction {
  final Bike bike;
  final String lastRouteName;
  final String staticRouteName;

  BikeUpdateRequestAction({
    @required this.bike,
    @required this.lastRouteName,
    @required this.staticRouteName,
  });

  @override
  String toString() {
    return 'BikeUpdateRequestAction {bikeID: ${bike.bikeID}';
  }
}

class BikeDeleteRequestAction {
  final int bikeID;

  BikeDeleteRequestAction({
    @required this.bikeID,
  });

  @override
  String toString() {
    return 'BikeDeleteRequestAction {bikeID: $bikeID}';
  }
}
