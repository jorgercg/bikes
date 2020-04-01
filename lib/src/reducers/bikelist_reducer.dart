import 'package:redux/redux.dart';

import '../actions/bike_actions.dart';
import '../models/bike_model.dart';

final bikeListReducer = combineReducers<List<Bike>>([
  TypedReducer<List<Bike>, BikeListIsLoadedAction>(_addBikeList),
  TypedReducer<List<Bike>, BikeIsAddedAction>(_addBike),
  TypedReducer<List<Bike>, BikeUpdateRequestAction>(_updateBike),
  TypedReducer<List<Bike>, BikeDeleteRequestAction>(_deleteBike),
]);

List<Bike> _addBikeList(List<Bike> bikeList, BikeListIsLoadedAction action) {
  return action.bikeList;
}

List<Bike> _addBike(List<Bike> bikeList, BikeIsAddedAction action) {
  bikeList.add(action.selectedBike);
  return bikeList;
}

List<Bike> _updateBike(List<Bike> bikeList, BikeUpdateRequestAction action) {
  return bikeList
      .map((Bike existingBike) => (existingBike.bikeID == action.bike.bikeID)
          ? action.bike
          : existingBike)
      .cast<Bike>()
      .toList();
}

List<Bike> _deleteBike(List<Bike> bikeList, BikeDeleteRequestAction action) {
  return bikeList.where((Bike bike) => bike.bikeID != action.bikeID).toList();
}
