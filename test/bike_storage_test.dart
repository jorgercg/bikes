import 'dart:io';

import 'package:bikes/src/models/bike_model.dart';
import 'package:bikes/src/storage/bike_storage.dart';
import 'package:test/test.dart';

void main() {
  group('BikeStorage', () {
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
    final testStorageDirectory =
        Directory.systemTemp.createTemp('test_storage_directory');
    final BikeStorage bikeStorage =
        BikeStorage('testStorageFileName', () => testStorageDirectory);

    test('SaveBikeList saves a list of Bikes to local storage', () async {
      final File file = await bikeStorage.saveBikeList(bikeList);
      expect(file.existsSync(), isTrue);
    });

    test('LoadBikeList returns a list of Bikes', () async {
      final List<Bike> loadedBikeList = await bikeStorage.loadBikeList();
      expect(loadedBikeList, bikeList);
    });
  });
}
