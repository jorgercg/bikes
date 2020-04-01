# Bikes

A Flutter Demo App project (Mobile only).

## General Usage Description

When you first execute the app, starting from a local asset file, a list of [Bike](./lib/src/models/bike_model.dart) entities is populated and shown to the user in a [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html) composed of a series of [Card](https://api.flutter.dev/flutter/material/Card-class.html) entities.

In each of those [BikeListCard](./lib/src/widgets/cards/bike_list_card.dart) cards there is a [ButtonBar](https://api.flutter.dev/flutter/material/ButtonBar-class.html) where you will find the edit and delete actions with the expected consequences. A single tab in the card opens a [BikeDetailScreen](./lib/src/screens/bike_detail_screen.dart) showing more characteristics of the selected bike. Furthermore, you can pinch-zoom the bike image.

On the bottom right of the main view there is a [FloatingActionButton](https://api.flutter.dev/flutter/material/FloatingActionButton-class.html) that when pressed creates an new empty instance of [Bike](./lib/src/models/bike_model.dart), saves it to local storage and opens the [BikeEditScreen](./lib/src/screens/bike_edit_screen.dart) with it.

## State Management

In this project we use [Redux](https://pub.dev/packages/redux) as the main state management architecture. Even tough in this simple case it could appear as overkill, we have in mind the scalability of such an approach focusing on much larger applications.

In the same manner, a [RxDart](https://pub.dev/packages/rxdart)-only BLoC system was used to the edit view, also in order to keep things pretty scalable.

When expanding this concept, we would have the same Redux type central store and there would be a dedicated BLoC to each edit view in the larger application.


## UX/UI

As for the UX/UI, a [MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html) was used, generally following its guidelines.


## Installing and Runnning

1. Install [Flutter](https://flutter.dev/docs/get-started/install)
2. Download or clone this [repository](https://github.com/jorgercg/bikes.git)
3. Enter bikes directory and execute:
```
flutter run
```


## Tests

Presently there are tests covering:
  * Redux Middleware
  * Redux Reducers
  * Bike Storage Class

To run the tests presently available execute:
```
flutter test
```


