import 'package:bikes/src/actions/bike_actions.dart';
import 'package:bikes/src/actions/formblank_actions.dart';
import 'package:bikes/src/actions/formmod_actions.dart';
import 'package:bikes/src/models/app_state.dart';
import 'package:bikes/src/models/bike_model.dart';
import 'package:bikes/src/reducers/app_reducer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  group('App State Reducers', () {
    final Bike bike1 = Bike(
      bikeCategory: '',
      bikeDescription: '',
      bikeFrameSize: '',
      bikeID: 1,
      bikeLocation: '',
      bikeName: '',
      bikePhotoURL: '',
      bikePriceRange: '',
    );
    final Bike bike2 = Bike(
      bikeCategory: '',
      bikeDescription: '',
      bikeFrameSize: '',
      bikeID: 2,
      bikeLocation: '',
      bikeName: '',
      bikePhotoURL: '',
      bikePriceRange: '',
    );

    test('Test if bikeList is correctly added', () {
      List<Bike> bikeList = [bike1, bike2];
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(),
      );
      store.dispatch(BikeListIsLoadedAction(bikeList: bikeList));
      expect(store.state.bikeList, bikeList);
    });

    test('Test if a Bike is correctly added to bikeList', () {
      List<Bike> bikeList = [bike1, bike2];
      final Bike bike3 = Bike(
        bikeCategory: '',
        bikeDescription: '',
        bikeFrameSize: '',
        bikeID: 3,
        bikeLocation: '',
        bikeName: '',
        bikePhotoURL: '',
        bikePriceRange: '',
      );
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(bikeList: bikeList),
      );
      List<Bike> newBikeList = store.state.bikeList;
      newBikeList.add(bike3);
      store.dispatch(BikeIsAddedAction(selectedBike: bike3));
      expect(store.state.bikeList, newBikeList);
    });

    test('Test if a Bike is correctly updated', () {
      List<Bike> bikeList = [bike1, bike2];
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(bikeList: bikeList),
      );
      Bike updatedBike = store.state.bikeList.first;
      updatedBike.bikeName = 'Bike updated';
      store.dispatch(BikeUpdateRequestAction(
        bike: updatedBike,
        lastRouteName: null,
        staticRouteName: null,
      ));
      expect(store.state.bikeList.first, updatedBike);
    });

    test('Test if a Bike is correctly deleted', () {
      List<Bike> bikeList = [bike1, bike2];
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(bikeList: bikeList),
      );
      List<Bike> newBikeList = store.state.bikeList;
      newBikeList.removeLast();
      store.dispatch(BikeDeleteRequestAction(bikeID: 2));
      expect(store.state.bikeList, newBikeList);
    });

    test('Test if formDataIsBlank is correctly toggled', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(formDataIsBlank: false),
      );
      store.dispatch(SetFormDataIsBlank(formDataIsBlank: true));
      expect(store.state.formDataIsBlank, true);
    });
    test('Test if formDataIsModified is correctly toggled', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(formDataIsModified: false),
      );
      store.dispatch(SetFormDataIsModified(formDataIsModified: true));
      expect(store.state.formDataIsModified, true);
    });
    test('''Test if bike is selected by BikeSelectionRequestAction and updated
         by BikeSelectedUpdateRequestAction''', () {
      List<Bike> bikeList = [bike1, bike2];
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(bikeList: bikeList),
      );
      store.dispatch(BikeSelectionRequestAction(selectedBike: bike1));
      expect(store.state.selectedBike, bike1);
      store.dispatch(BikeSelectedUpdateRequestAction(selectedBike: bike2));
      expect(store.state.selectedBike, bike2);
    });
  });
}
