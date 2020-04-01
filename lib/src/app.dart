import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import './constants.dart';
import './containers/bike_edit_container.dart';
import './containers/bike_detail_container.dart';
import './containers/bike_list_container.dart';
import './keys.dart';
import './middleware/bike_middleware.dart';
import './models/app_state.dart';
import './reducers/app_reducer.dart';
import './screens/splash.dart';
import './storage/bike_storage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetching app docs dir and filename and injecting on storage class
    final appDocsDirectory = getApplicationDocumentsDirectory();
    final BikeStorage bikeStorage =
        BikeStorage(storageFileName, () => appDocsDirectory);
    
    final store = Store<AppState>(
      appReducer,
      initialState: AppState(),
      distinct: true,
      middleware: [
        ...createBikeMiddleware(bikeStorage),
        ...[LoggingMiddleware.printer()]
      ],
    );

    return StoreProvider(
      store: store,
      child: MaterialApp(
        navigatorKey: AppKeys.navKey,
        title: appTitle,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue[800],
          accentColor: Colors.blue[300],
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          SplashScreen.route: (context) => SplashScreen(),
          BikeListContainer.route: (context) => BikeListContainer(),
          BikeDetailContainer.route: (context) => BikeDetailContainer(),
          BikeEditContainer.route: (context) => BikeEditContainer(),
        },
      ),
    );
  }
}
