import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';

import '../actions/bike_actions.dart';
import '../keys.dart';
import '../models/app_state.dart';

/// This class fires the [LoadBikeListRequestAction] and 
/// shows progress widget while the data is loaded, when it 
/// happens the [BikeListContainer] will be loaded.
class SplashScreen extends StatelessWidget {
  SplashScreen() : super(key: AppKeys.splashScreen);

  static const String route = '/splash';

  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/undraw_biking_kc4f.svg';
    final Widget svgWidget = SvgPicture.asset(
      assetName,
      fit: BoxFit.fitWidth,
      semanticsLabel: 'Empty list',
    );
    return StoreBuilder(onInit: (Store<AppState> store) {
      store.dispatch(LoadBikeListRequestAction());
    }, builder: (BuildContext context, Store<AppState> store) {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Container(
                width: 0.8 * (MediaQuery.of(context).size.width),
                child: svgWidget,
              ),
            ),
            LinearProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
            ),
          ],
        ),
      );
    });
  }
}
