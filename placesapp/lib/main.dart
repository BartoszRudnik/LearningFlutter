import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/greatPlaces.dart';
import 'screens/addPlace.dart';
import 'screens/placeDetail.dart';
import 'screens/placesList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesList(),
        routes: {
          PlaceDetail.routeName: (ctx) => PlaceDetail(),
          AddPlace.routeName: (ctx) => AddPlace(),
        },
      ),
    );
  }
}
