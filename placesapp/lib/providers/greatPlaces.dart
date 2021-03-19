import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:placesapp/helpers/locationHelper.dart';

import '../helpers/dbHelper.dart';
import '../models/place.dart';
import '../models/placeLocation.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [...this._items];
  }

  Future<void> addPlace(String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final finalAddress = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: finalAddress,
      image: image,
    );

    this._items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Place findPlaceById(String id) {
    return this._items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    this._items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            image: File(e['image']),
            title: e['title'],
            location: PlaceLocation(
              latitude: e['loc_lat'],
              longitude: e['loc_lng'],
              address: e['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
