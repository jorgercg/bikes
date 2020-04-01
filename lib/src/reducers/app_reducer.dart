import '../models/app_state.dart';
import './bikelist_reducer.dart';
import './formblank_reducer.dart';
import './formmod_reducer.dart';
import './selectedbike_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    selectedBike: selectedBikeReducer(state.selectedBike, action),
    bikeList: bikeListReducer(state.bikeList, action),
    formDataIsBlank: formblankReducer(state.formDataIsBlank, action),
    formDataIsModified: formmodReducer(state.formDataIsModified, action),
  );
}
