import 'package:flutter/material.dart';

class AppKeys {
  static final navKey = GlobalKey<NavigatorState>(debugLabel:'NavigatorGlobalKey');
  
  static final splashScreen = const Key('__splashScreen__');
  
  static final bikeEditScreen = const Key('__bikeEditScreen__');
  static final bikeListItemCard = (int id) => Key('BikeList__${id}__ItemCard');
  static final bikeEditLineItem = (String label) => Key('BikeEdit__${label}__LineItem');
}