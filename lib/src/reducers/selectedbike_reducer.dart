import 'package:redux/redux.dart';

import '../actions/bike_actions.dart';
import '../models/bike_model.dart';

final selectedBikeReducer = combineReducers<Bike>([
  TypedReducer<Bike, BikeSelectionRequestAction>(_selectBike),
  TypedReducer<Bike, BikeSelectedUpdateRequestAction>(_updateSelectedBike),
]);

Bike _selectBike(Bike selectedBike, action) {
  return action.selectedBike;
}

Bike _updateSelectedBike(Bike selectedBike, action) {
  return action.selectedBike;
}
