class Bike {
  int bikeID;
  String bikeFrameSize;
  String bikeCategory;
  String bikeLocation;
  String bikeName;
  String bikePhotoURL;
  String bikePriceRange;
  String bikeDescription;

  Bike({
    this.bikeID,
    this.bikeFrameSize,
    this.bikeCategory,
    this.bikeLocation,
    this.bikeName,
    this.bikePhotoURL,
    this.bikePriceRange,
    this.bikeDescription,
  });

  factory Bike.fromJson(Map<String, dynamic> parsedJson) {
    return Bike(
      bikeID: parsedJson["id"],
      bikeFrameSize: parsedJson["frameSize"],
      bikeCategory: parsedJson["category"],
      bikeLocation: parsedJson["location"],
      bikeName: parsedJson["name"],
      bikePhotoURL: parsedJson["photoUrl"],
      bikePriceRange: parsedJson["priceRange"],
      bikeDescription: parsedJson["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": bikeID,
      "frameSize": bikeFrameSize,
      "category": bikeCategory,
      "location": bikeLocation,
      "name": bikeName,
      "photoUrl": bikePhotoURL,
      "priceRange": bikePriceRange,
      "description": bikeDescription,
    };
  }

  @override
  String toString() {
    return 'Bike {bikeID: $bikeID, bikeFrameSize: $bikeFrameSize, bikeCategory: $bikeCategory, bikeLocation: $bikeLocation, bikeName: $bikeName, bikePhotoURL: $bikePhotoURL, bikePriceRange: $bikePriceRange, bikeDescription: $bikeDescription}';
  }

  @override
  int get hashCode =>
      bikeID.hashCode ^
      bikeFrameSize.hashCode ^
      bikeCategory.hashCode ^
      bikeLocation.hashCode ^
      bikeName.hashCode ^
      bikePhotoURL.hashCode ^
      bikePriceRange.hashCode ^
      bikeDescription.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bike &&
          runtimeType == other.runtimeType &&
          bikeID == other.bikeID &&
          bikeFrameSize == other.bikeFrameSize &&
          bikeCategory == other.bikeCategory &&
          bikeLocation == other.bikeLocation &&
          bikeName == other.bikeName &&
          bikePhotoURL == other.bikePhotoURL &&
          bikePriceRange == other.bikePriceRange &&
          bikeDescription == other.bikeDescription;
}
