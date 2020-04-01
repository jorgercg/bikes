import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;

import '../models/bike_model.dart';

/// Loads and saves a Bike list from the device.
/// In the first startup after install, the file comes from assets.
/// From that moment on, all storage is done in a text file stored
/// on local storage.
/// The getStorageDirectory is injected to make testing easier.
class BikeStorage {
  final String fileName;
  final Future<Directory> Function() getStorageDirectory;

  const BikeStorage(this.fileName, this.getStorageDirectory);

  Future<String> get _localPath async {
    final Directory directory = await getStorageDirectory();
    return directory.path;
  }

  Future<File> _getlocalFile() async {
    final String path = await _localPath;
    return File('$path/$fileName');
  }

  Future<String> _loadFileFromAssets() async {
    return await rootBundle.loadString('assets/' + fileName);
  }

  Future<dynamic> _loadFileFromLocalStorage() async {
    final localFile = await _getlocalFile();
    try {
      return await localFile.readAsString();
    } catch (error) {
      print('Error at _loadFileFromLocalStorage:[$error]');
      return false;
    }
  }

  Future<dynamic> _saveFileToLocalStorage(String fileContents) async {
    final localFile = await _getlocalFile();
    try {
      await localFile.writeAsString(fileContents);
    } catch (error) {
      print('Error at _saveFileToLocalStorage:[$error]');
      return false;
    }
  }

  Future<List<Bike>> loadBikeList() async {
    dynamic fileContents = await _loadFileFromLocalStorage();
    if (fileContents is bool) {
      fileContents = await _loadFileFromAssets();
      await _saveFileToLocalStorage(fileContents);
    }
    return JsonDecoder()
        .convert(fileContents)
        .map<Bike>((jsonBike) => Bike.fromJson(jsonBike))
        .toList();
  }

  Future<dynamic> saveBikeList(List<Bike> bikeList) async {
    final localFile = await _getlocalFile();
    try {
      return localFile.writeAsString(
          json.encode(bikeList.map((bike) => bike.toJson()).toList()));
    } catch (error) {
      print('Error at saveBikeList:[$error]');
      return error.toString();
    }
  }
}
