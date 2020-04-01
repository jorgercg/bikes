import 'package:bikes/src/actions/bike_actions.dart';
import 'package:bikes/src/middleware/bike_middleware.dart';
import 'package:bikes/src/models/app_state.dart';
import 'package:bikes/src/models/bike_model.dart';
import 'package:bikes/src/reducers/app_reducer.dart';
import 'package:bikes/src/storage/bike_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

class MockBikeStorage extends Mock implements BikeStorage {}

void main() {
  group('Middleware Tests', () {
    test('if BikeMiddleware reacts correctly to LoadBikeListRequestAction', () {
      final mockBikeStorage = MockBikeStorage();
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(),
        middleware: createBikeMiddleware(mockBikeStorage),
      );
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
      final List<Bike> bikeList = [bike1, bike2];
      when(mockBikeStorage.loadBikeList())
          .thenAnswer((_) => Future.value(bikeList));
      store.dispatch(LoadBikeListRequestAction());
      verify(mockBikeStorage.loadBikeList());
    });

    test('if BikeMiddleware reacts correctly to BikeAddRequestAction', () {
      final mockBikeStorage = MockBikeStorage();
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(bikeList: <Bike>[]),
        middleware: createBikeMiddleware(mockBikeStorage),
      );
      store.dispatch(BikeAddRequestAction());
      verify(mockBikeStorage.saveBikeList(any)).called(1);
    });

    test('if BikeMiddleware reacts correctly to BikeDeleteRequestAction', () {
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
      final List<Bike> bikeList = [bike1, bike2];
      final mockBikeStorage = MockBikeStorage();
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(bikeList: bikeList),
        middleware: createBikeMiddleware(mockBikeStorage),
      );
      store.dispatch(BikeDeleteRequestAction(bikeID: 1));
      verify(mockBikeStorage.saveBikeList(any)).called(1);
    });

    test('if BikeMiddleware reacts correctly to BikeUpdateRequestAction', () {
      Bike bike1 = Bike(
        bikeCategory: '',
        bikeDescription: '',
        bikeFrameSize: '',
        bikeID: 1,
        bikeLocation: '',
        bikeName: '',
        bikePhotoURL: '',
        bikePriceRange: '',
      );
      Bike bike2 = Bike(
        bikeCategory: '',
        bikeDescription: '',
        bikeFrameSize: '',
        bikeID: 2,
        bikeLocation: '',
        bikeName: '',
        bikePhotoURL: '',
        bikePriceRange: '',
      );
      List<Bike> bikeList = [bike1, bike2];
      final mockBikeStorage = MockBikeStorage();
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(bikeList: bikeList),
        middleware: createBikeMiddleware(mockBikeStorage),
      );
      Bike updatedBike = store.state.bikeList.first;
      updatedBike.bikeName = 'Bike updated';
      store.dispatch(BikeUpdateRequestAction(
        bike: updatedBike,
        staticRouteName: null,
        lastRouteName: null,
      ));
      verify(mockBikeStorage.saveBikeList(any)).called(1);
      expect(store.state.bikeList, [updatedBike, bike2]);
    });
  });
}
