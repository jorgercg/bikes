import 'package:collection/collection.dart';

import './bike_model.dart';

class AppState {
  final Bike selectedBike;
  final List<Bike> bikeList;
  final bool formDataIsBlank;
  final bool formDataIsModified;

  AppState({
    this.selectedBike,
    this.bikeList,
    this.formDataIsBlank = false,
    this.formDataIsModified = false,
  });

  AppState copyWith({
    Bike selectedBike,
    List<Bike> bikeList,
    bool formDataIsBlank,
    bool formDataIsModified,
  }) {
    return AppState(
      selectedBike: selectedBike ?? this.selectedBike,
      bikeList: bikeList ?? this.bikeList,
      formDataIsBlank: formDataIsBlank ?? this.formDataIsBlank,
      formDataIsModified: formDataIsModified ?? this.formDataIsModified,
    );
  }

  @override
  String toString() {
    return 'AppState {selectedBike:$selectedBike, bikeList:$bikeList}';
  }

  @override
  int get hashCode =>
      selectedBike.hashCode ^
      bikeList.hashCode ^
      formDataIsBlank.hashCode ^
      formDataIsModified.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          selectedBike == other.selectedBike &&
          ListEquality().equals(bikeList, other.bikeList) &&
          formDataIsBlank == other.formDataIsBlank &&
          formDataIsModified == other.formDataIsModified;
}
